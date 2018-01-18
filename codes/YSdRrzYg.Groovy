package org.linqs.psl.examples.trustprediction;

import org.linqs.psl.application.inference.LazyMPEInference;
import org.linqs.psl.application.inference.MPEInference;
import org.linqs.psl.application.learning.weight.maxlikelihood.LazyMaxLikelihoodMPE;
import org.linqs.psl.application.learning.weight.maxlikelihood.MaxLikelihoodMPE;
import org.linqs.psl.application.learning.weight.maxlikelihood.VotedPerceptron;
import org.linqs.psl.config.ConfigBundle;
import org.linqs.psl.config.ConfigManager;
import org.linqs.psl.database.Database;
import org.linqs.psl.database.DatabasePopulator;
import org.linqs.psl.database.DataStore;
import org.linqs.psl.database.Partition;
import org.linqs.psl.database.Queries;
import org.linqs.psl.database.loading.Inserter;
import org.linqs.psl.database.rdbms.driver.H2DatabaseDriver;
import org.linqs.psl.database.rdbms.driver.H2DatabaseDriver.Type;
import org.linqs.psl.database.rdbms.RDBMSDataStore;
import org.linqs.psl.evaluation.statistics.RankingComparator;
import org.linqs.psl.evaluation.statistics.RankingScore;
import org.linqs.psl.groovy.PSLModel;
import org.linqs.psl.model.atom.GroundAtom;
import org.linqs.psl.model.term.Constant;
import org.linqs.psl.model.term.ConstantType;
import org.linqs.psl.utils.dataloading.InserterUtils;
import org.linqs.psl.model.term.Variable;
import org.linqs.psl.model.atom.QueryAtom;
import org.linqs.psl.model.term.UniqueIntID;
import java.io.File

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Paths;

public class Run {
	private static final String PARTITION_LEARN_OBSERVATIONS = "learn_observations";
	private static final String PARTITION_LEARN_TARGETS = "learn_targets";
	private static final String PARTITION_LEARN_TRUTH = "learn_truth";

	private static final String PARTITION_EVAL_OBSERVATIONS = "eval_observations";
	private static final String PARTITION_EVAL_TARGETS = "eval_targets";
	private static final String PARTITION_EVAL_TRUTH = "eval_truth";

	private static final String DATA_PATH = Paths.get("..", "data", "trust-prediction").toString();
	private static final String OUTPUT_PATH = "inferred-predicates";

	private static Logger log = LoggerFactory.getLogger(Run.class)

	private DataStore dataStore;
	private ConfigBundle config;
	private PSLModel model;

	public Run() {
		config = ConfigManager.getManager().getBundle("trustprediction");
		System.out.println("hello world");
		// System.out.println(config.as)
		String suffix = System.getProperty("user.name") + "@" + getHostname();
		String baseDBPath = config.getString("dbpath", System.getProperty("java.io.tmpdir"));
		String dbPath = Paths.get(baseDBPath, this.getClass().getName() + "_" + suffix).toString();
		dataStore = new RDBMSDataStore(new H2DatabaseDriver(Type.Disk, dbPath, true), config);

		model = new PSLModel(this, dataStore);
	}

	/**
	 * Defines the logical predicates used in this model
	 */
	private void definePredicates() {
		model.add predicate: "Trustworthy", types: [ConstantType.UniqueIntID];
		model.add predicate: "Strong", types: [ConstantType.UniqueIntID, ConstantType.UniqueIntID];
		model.add predicate: "Moderate", types: [ConstantType.UniqueIntID, ConstantType.UniqueIntID];
		model.add predicate: "Weak", types: [ConstantType.UniqueIntID, ConstantType.UniqueIntID];
		model.add predicate: "Prior", types: [ConstantType.UniqueIntID];
	}

	/**
	 * Defines the rules for this model.
	 */
	private void defineRules() {
		log.info("Defining model rules");

		// We will just add all the rules in bulk.
		// Note that comments are allowed.
		model.addRules("""
  		// Positive rules
			0.8: Trustworthy(A) & Strong(A, B) & A!=B -> Trustworthy(B) ^2
			0.8: Trustworthy(A) & Strong(B, A)  & A!=B -> Trustworthy(B) ^2
			0.1: Trustworthy(A) & Moderate(A, B)  & A!=B -> Trustworthy(B) ^2
			0.8: Trustworthy(A) & Moderate(B, A)  & A!=B -> Trustworthy(B) ^2
			0.01: Trustworthy(A) & Weak(A, B)  & A!=B -> Trustworthy(B) ^2
			0.8: Trustworthy(A) & Weak(B, A)  & A!=B -> Trustworthy(B) ^2
      // Negative rules
			3.0: !Trustworthy(A) & Strong(A, B)  & A!=B -> !Trustworthy(B) ^2
			3.0: !Trustworthy(A) & Strong(B, A)  & A!=B -> !Trustworthy(B) ^2
			1.0: !Trustworthy(A) & Moderate(A, B)  & A!=B -> !Trustworthy(B) ^2
			1.0: !Trustworthy(A) & Moderate(B, A)  & A!=B -> !Trustworthy(B) ^2
			1.0: !Trustworthy(A) & Weak(A, B)  & A!=B -> !Trustworthy(B) ^2
			1.0: !Trustworthy(A) & Weak(B, A)  & A!=B -> !Trustworthy(B) ^2
			3.0: !Trustworthy(A) ^2
			// 4.0: Trustworthy(A) & !Strong(A, B)  & A!=B -> !Trustworthy(B) ^2
			// 4.0: Trustworthy(A) & !Strong(B, A)  & A!=B -> !Trustworthy(B) ^2
			// 1: Prior('0') -> !Trustworthy(A)
		""");

		// model.add PredicateConstraint.Functional, on: Trustworthy

		log.debug("model: {}", model);
	}

	/**
	 * Load data from text files into the DataStore.
	 * Three partitions are defined and populated: observations, targets, and truth.
	 * Observations contains evidence that we treat as background knowledge and use to condition our inferences.
	 * Targets contains the inference targets - the unknown variables we wish to infer.
	 * Truth contains the true values of the inference variables and will be used to evaluate the model's performance.
	 */
	private void loadData() {
		log.info("Loading data into database");

		for (String type : ["learn", "eval"]) {
			Partition obsPartition = dataStore.getPartition(type + "_observations");
			Partition targetsPartition = dataStore.getPartition(type + "_targets");
			Partition truthPartition = dataStore.getPartition(type + "_truth");

			Inserter inserter = dataStore.getInserter(Strong, obsPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "strong_obs.txt").toString());

			inserter = dataStore.getInserter(Moderate, obsPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "moderate_obs.txt").toString());

			inserter = dataStore.getInserter(Weak, obsPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "weak_obs.txt").toString());

			inserter = dataStore.getInserter(Trustworthy, obsPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "trustworthy_obs.txt").toString());

			inserter = dataStore.getInserter(Trustworthy, targetsPartition);
			InserterUtils.loadDelimitedData(inserter, Paths.get(DATA_PATH, type, "trustworthy_target.txt").toString());

			inserter = dataStore.getInserter(Trustworthy, truthPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "trustworthy_truth.txt").toString());

			inserter = dataStore.getInserter(Prior, obsPartition);
			InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, type, "prior_obs.txt").toString());
		}

		Partition unobservedAtoms = dataStore.getPartition("unobserved_atoms");
		Inserter inserter = dataStore.getInserter(Trustworthy, unobservedAtoms);
		InserterUtils.loadDelimitedDataTruth(inserter, Paths.get(DATA_PATH, "learn", "unobserved_nodes.txt").toString());

	}

	/**
	 * Use the training data to learn weights for our rules and store them back in the model object.
	 */
	private void learnWeights() {
		log.info("Starting weight learning");

		Partition obsPartition = dataStore.getPartition(PARTITION_LEARN_OBSERVATIONS);
		Partition targetsPartition = dataStore.getPartition(PARTITION_LEARN_TARGETS);
		Partition truthPartition = dataStore.getPartition(PARTITION_LEARN_TRUTH);

		// This database contains all the ground atoms (targets) that we want to infer.
		// It also includes the observed data (because we will run inference over this db).
		Database randomVariableDatabase = dataStore.getDatabase(targetsPartition, [Strong, Moderate, Weak, Prior] as Set, obsPartition);

		// This database only contains the true ground atoms.
		Database observedTruthDatabase = dataStore.getDatabase(truthPartition,
																													dataStore.getRegisteredPredicates());

		VotedPerceptron vp = new MaxLikelihoodMPE(model, randomVariableDatabase, observedTruthDatabase, config);
		vp.learn();

		randomVariableDatabase.close();
		observedTruthDatabase.close();

		log.info("Weight learning complete");
	}

	private Set<UniqueIntID> readDomainIDs(Database db) {
		Set<String> domainSet = new HashSet();
		def file = new File(DATA_PATH+'/learn/strong_obs.txt');
		// println file.text
		def lines = file.readLines()

		lines.each {
			String line -> println line;
			def domains = line.split('\t');
			domainSet.add(dataStore.getUniqueID(1));
			domainSet.add(db.getUniqueID(domains[0]));
			domainSet.add(db.getUniqueID(domains[1]));
			println domains[0];
			println domains[1];
		}
		return domainSet;
	}

	private void loadUnObservedAtoms() {
		log.info("Loading Unobserved Atoms");

		// readDomainIDs();

		Partition obsPartition = dataStore.getPartition(PARTITION_LEARN_OBSERVATIONS);
		Partition targetsPartition = dataStore.getPartition(PARTITION_LEARN_TARGETS);
		// DatabasePopulator dbPop;
		Database distributionDB = dataStore.getDatabase(targetsPartition, [Strong, Moderate, Weak] as Set, obsPartition);
		Variable A = new Variable("Domain");
		def subsitutions = new HashMap<Variable, Set<String>>();
		Set<String> aSetOfDomainGroundTerms = readDomainIDs(distributionDB);
		subsitutions.put(A, aSetOfDomainGroundTerms);

		DatabasePopulator dbPop = new DatabasePopulator(distributionDB);
		dbPop.populate(new QueryAtom(Trustworthy, A), subsitutions);
	}

	/**
	 * Run inference to infer the unknown HasCat relationships between people.
	 */
	private void runInference() {
		log.info("Starting inference");

		Partition obsPartition = dataStore.getPartition(PARTITION_LEARN_OBSERVATIONS);
		Partition targetsPartition = dataStore.getPartition(PARTITION_LEARN_TARGETS);
		// Partition unObservedAtoms = dataStore.getPartition("unobserved_atoms");
		// Database inferDB = dataStore.getDatabase(targetsPartition, [, Prior] as Set, obsPartition);
		Database inferDB = dataStore.getDatabase(targetsPartition,  [Strong, Moderate, Weak] as Set, obsPartition);

		LazyMPEInference mpe = new LazyMPEInference(model, inferDB, config);
		mpe.mpeInference();

		mpe.close();
		inferDB.close();

		log.info("Inference complete");
	}

	/**
	 * Writes the output of the model into a file
	 */
	private void writeOutput() {
		Database resultsDB = dataStore.getDatabase(dataStore.getPartition(PARTITION_EVAL_TARGETS));

		(new File(OUTPUT_PATH)).mkdirs();
		FileWriter writer = new FileWriter(Paths.get(OUTPUT_PATH, "TRUSTS.txt").toString());

		for (GroundAtom atom : Queries.getAllAtoms(resultsDB, Trustworthy)) {
			for (Constant argument : atom.getArguments()) {
				writer.write(argument.toString() + "\t");
			}
			writer.write("" + atom.getValue() + "\n");
		}

		writer.close();
		resultsDB.close();
	}

	/**
	 * Run statistical evaluation scripts to determine the quality of the inferences
	 * relative to the defined truth.
	 */
	private void evalResults() {
		// Because the truth data also includes observed data, we will make sure to include the observed
		// partition here.
		Database resultsDB = dataStore.getDatabase(dataStore.getPartition(PARTITION_EVAL_TARGETS),
				[Prior] as Set, dataStore.getPartition(PARTITION_EVAL_OBSERVATIONS));
		Database truthDB = dataStore.getDatabase(dataStore.getPartition(PARTITION_EVAL_TRUTH),
				dataStore.getRegisteredPredicates());

		RankingComparator comparator = new RankingComparator(resultsDB, truthDB, 0.5);
		RankingScore stats = comparator.compare(Trustworthy);

		log.info("AUROC: {}", stats.auroc());
		log.info("Positive Class AUPRC: {}", stats.auprc());
		log.info("Negative Class AUPRC: {}", stats.negAUPRC());

		resultsDB.close();
		truthDB.close();
	}

	public void run() {
		definePredicates();
		defineRules();
		loadData();
		// loadUnObservedAtoms();
		// learnWeights();
		runInference();

		writeOutput();
		evalResults();

		dataStore.close();
	}

	/**
	 * Run this model from the command line
	 * @param args - the command line arguments
	 */
	public static void main(String[] args) {
		Run run = new Run();
		run.run();
	}

	private static String getHostname() {
		String hostname = "unknown";

		try {
			hostname = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException ex) {
			log.warn("Hostname can not be resolved, using '" + hostname + "'.");
		}

		return hostname;
	}
}