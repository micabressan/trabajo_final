@JsonProperty( "inherit" )
    public Builder inherit(String inheritPath) {
      this.inherit = inheritPath; //readEnvironmentFile( new File( inheritPath ) );
      return this;
    }

    @VisibleForTesting
    @JsonIgnore
    public Builder inherit(Environment environment) {
      this.inheritEnvironment = environment;
      return this;
    }

    @JsonProperty( "outputPath" )
    public Builder outputPath(String outputPath) {
      this.outputPath = outputPath;
      return this;
    }

    @JsonProperty( "codeOutputPath" )
    public Builder codeOutputPath(String codeOutputPath) {
      this.codeOutputPath = codeOutputPath;
      return this;
    }

    @JsonProperty( "dataOutputPath" )
    public Builder dataOutputPath(String dataOutputPath) {
      this.dataOutputPath = dataOutputPath;
      return this;
    }

    @JsonProperty( "workflowRootPath" )
    public Builder workflowRootPath(String workflowRootPath) {
      this.workflowRootPath = workflowRootPath;
      return this;
    }

    @JsonProperty( "servicesPath" )
    public Builder servicesPath(String servicesPath) {
      this.servicesPath = servicesPath;
      return this;
    }

    @JsonProperty( "fileSearchPaths" )
    public Builder fileSearchPaths(String... fileSearchPaths) {
      return this.fileSearchPaths( Arrays.asList( fileSearchPaths ) );
    }

    public Builder fileSearchPaths(Iterable<String> fileSearchPaths) {
      this.fileSearchPaths = MoreLists.immutableCopyOf( fileSearchPaths );
      return this;
    }

    @JsonProperty( "libraryOutputPaths" )
    public Builder libraryOutputPaths(Map<String, String> libraryOutputPaths) {
      this.libraryOutputPaths = Maps.newHashMap( libraryOutputPaths );
      return this;
    }

    @JsonProperty( "parameters" )
    public Builder parameters(Map<String, String> parameters) {
      this.parameters = Maps.newHashMap( parameters );
      return this;
    }

    public Builder mergeParameters(Map<String, String> parameters) {
      if( this.parameters == null ) {
        return parameters( parameters );
      }
      this.parameters.putAll( parameters );
      return this;
    }

    @JsonProperty( "targets" )
    public Builder targetOptions(TargetEnvironmentOptions... targetOptions) {
      return targetOptions( Arrays.asList( targetOptions ) );
    }

    public Builder targetOptions(Iterable<TargetEnvironmentOptions> targetOptions) {
      this.targets = MoreSets.immutableCopyOf( targetOptions );
      return this;
    }

    @JsonProperty( "workflows" )
    public Builder workflowOptions(TargetEnvironmentOptions... workflowOptions) {
      return workflowOptions( MoreSets.immutableCopyOf( workflowOptions ) );
    }

    public Builder workflowOptions(Iterable<TargetEnvironmentOptions> workflowOptions) {
      this.workflows = MoreSets.immutableCopyOf( workflowOptions );
      return this;
    }

    @JsonProperty( "servers" )
    public Builder serverOptions(TargetEnvironmentOptions... serverOptions) {
      return serverOptions( MoreSets.immutableCopyOf( serverOptions ) );
    }

    public Builder serverOptions(Iterable<TargetEnvironmentOptions> serverOptions) {
      this.servers = MoreSets.immutableCopyOf( serverOptions );
      return this;
    }

    @JsonProperty( "logging" )
    public Builder logging(LoggingConfiguration logging) {
      this.logging = logging;
      return this;
    }

    @JsonProperty( "outputDefinition" )
    public Builder outputDefinition(ViewOutput outputDefinition) {
      this.outputDefinition = outputDefinition;
      return this;
    }

    @JsonProperty( "ontologyPath" )
    public Builder ontologyPath(String ontologyPath) {
      this.ontologyPath = ontologyPath;
      return this;
    }

    @JsonProperty( "ontology" )
    public Builder ontology(DataOntology ontology) {
      this.ontology = ontology;
      return this;
    }

    @JsonProperty( "timeZone" )
    public Builder timeZone(String timeZone) {
      this.timeZone = timeZone;
      return this;
    }

    @JacksonInject( DataViewObjectMapper.INJECT_FILE )
    public Builder envFilePath(String envFilePath) {
      this.envFilePath = envFilePath;
      return this;
    }

    @JsonProperty( "projectMetadataPath" )
    public Builder projectMetadataPath(String projectMetadataPath) {
      this.projectMetadataPath = projectMetadataPath;
      return this;
    }

    @JsonProperty( "phantomjsPath" )
    public Builder phantomjsPath(String phantomjsPath) {
      this.phantomjsPath = phantomjsPath;
      return this;
    }

    @JsonProperty( "pythonPath" )
    public Builder pythonPath(String pythonPath) {
      this.pythonPath = pythonPath;
      return this;
    }
    
    @JsonProperty( "pypyPath" )
    public Builder pypyPath(String pypyPath) {
      this.pypyPath = pypyPath;
      return this;
    }

    @JsonProperty( "jythonPath" )
    public Builder jythonPath(String jythonPath) {
      this.jythonPath = jythonPath;
      return this;
    }

    @JsonProperty( "encrypted" )
    public Builder encrypted(Boolean encrypted) {
      this.encrypted = ( encrypted == null ) ? false : encrypted;
      return this;
    }
[14:09:02] Jan Katrenic: public class JavaForkEnvironmentOptions {
  @JsonProperty("javaHome")
  @NotNull
  private final File javaHome;
  @JsonProperty("maxHeapSize")
  @NotBlank
  private final String maxHeapSize;
  @JsonProperty("vmArgs")
  @NotNull
  private final List<String> vmArgs;
[14:10:18] Jan Katrenic:   @JsonProperty( "db" )
  @NotNull
  private final String db;
  
  @JsonProperty( "sqlDialect" )
  @NotNull
  private final SQLDialect sqlDialect;
  
  @JsonProperty( "user" )
  @NotNull
  private final String user;
  
  @JsonProperty( "password" )
  @NotNull
  private final String password;
  
  @JsonProperty( "driver" )
  @NotNull
  private final String driver;
  
  @JsonProperty( "scheme" )
  @NotNull
  private final String scheme;