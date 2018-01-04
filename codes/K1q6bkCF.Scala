package fr.univ_lille.cristal.emeraude.n2s3.apps

import fr.univ_lille.cristal.emeraude.n2s3.core.ConnectionIndex
import fr.univ_lille.cristal.emeraude.n2s3.core.models.properties._
import fr.univ_lille.cristal.emeraude.n2s3.features.builder.N2S3
import fr.univ_lille.cristal.emeraude.n2s3.features.builder.connection.types.FullConnection
import fr.univ_lille.cristal.emeraude.n2s3.features.io.input.N2S3InputStreamCombinators._
import fr.univ_lille.cristal.emeraude.n2s3.features.io.input._
import fr.univ_lille.cristal.emeraude.n2s3.features.logging.InputOutputGraphNetworkObserver
import fr.univ_lille.cristal.emeraude.n2s3.features.logging.graph.{SynapticWeightSelectGraph, SynapticWeightSelectGraphRef}
import fr.univ_lille.cristal.emeraude.n2s3.models.neurons.LIF
import fr.univ_lille.cristal.emeraude.n2s3.models.synapses.{InhibitorySynapse, QBGParameters, SimplifiedSTDP}
import fr.univ_lille.cristal.emeraude.n2s3.support.N2S3ResourceManager
import fr.univ_lille.cristal.emeraude.n2s3.support.UnitCast._
import squants.electro.ElectricPotentialConversions.ElectricPotentialConversions

/**
  * Experience reproduced from:
  * Extraction of temporally correlated features from dynamic vision sensors with spike-timing-dependent plasticity
  * O Bichler, D Querlioz, SJ Thorpe, JP Bourgoin, C Gamrat, Neural Networks 32
  */

object ExampleFreeWay extends App {

  val n2s3 = new N2S3()
  var lastTimestamp: Long = 0

  QBGParameters.alf_m = 0.05f
  QBGParameters.alf_p = 0.1f
  QBGParameters.beta_m = 0f
  QBGParameters.beta_p = 0f

  QBGParameters.init_mean = 0.8f
  QBGParameters.init_std = 0.16f

  val dataFile =  N2S3ResourceManager.getByName("freeway-dvs").getAbsolutePath
  val retinaStream =  InputAER.Entry >> InputAER.Retina(128, 128, separateSign = false) >> N2S3Entry
  val inputLayer = n2s3.createInput(retinaStream)


  val layer1 = n2s3.createNeuronGroup()
    .setIdentifier("Layer1")
    .setNumberOfNeurons(60)
    .setNeuronModel(LIF,  Seq(
      (MembraneThresholdType, MembraneThresholdTypeEnum.Static),
      (MembranePotentialThreshold, 1060 millivolts),
      (MembraneRefractoryDuration, 517 MilliSecond),
      (MembraneInhibitionDuration, 10.2 MilliSecond),
      (MembraneLeakTime, 187 MilliSecond)))

  val layer2 = n2s3.createNeuronGroup()
    .setIdentifier("Layer2")
    .setNumberOfNeurons(10)
    .setNeuronModel(LIF,  Seq(
      (MembraneThresholdType, MembraneThresholdTypeEnum.Static),
      (MembranePotentialThreshold, 2.24 millivolts),
      (MembraneRefractoryDuration, 470 MilliSecond),
      (MembraneInhibitionDuration, 182 MilliSecond),
      (MembraneLeakTime, 477 MilliSecond)))

  inputLayer.connectTo(layer1, new FullConnection(() => new SimplifiedSTDP(14.7 MilliSecond)))
  val Layer1WTAconnection = layer1.connectTo(layer1, new FullConnection(() => new InhibitorySynapse))

  n2s3.create()

  val inputToLayer1Index = new ConnectionIndex(inputLayer, layer1)

  n2s3.addNetworkObserver(new SynapticWeightSelectGraphRef(
    for(outputIndex <- 0 until layer1.shape.getNumberOfPoints) yield {
      for(inputX <- 0 until 128) yield {
        for(inputY <- 0 until 128) yield {
          val input = inputLayer.getNeuronPathAt(inputX, inputY)
          val output = layer1.getNeuronPathAt(outputIndex)
          inputToLayer1Index.getConnectionsBetween(input, output).head
        }
      }
    },
    SynapticWeightSelectGraph.heatMap,
    1,
    100)
  )

  n2s3.addNetworkObserver(InputOutputGraphNetworkObserver(Seq(
    (inputLayer, 128, 4),
    (layer1, 10, 4),
    (layer2, 2, 4))))

  println("### Training First Layer ###")
  retinaStream.append(InputAER.DataFromFile(dataFile).repeat(8))
  n2s3.runAndWait()



  println("### Training Second Layer ###")

  layer1.fixNeurons()
  Layer1WTAconnection.disconnect()
  layer1.connectTo(layer2, new FullConnection(() => new SimplifiedSTDP(46.5 MilliSecond)))
  val Layer2WTAconnection = layer2.connectTo(layer2, new FullConnection(() => new InhibitorySynapse))
  /*
    n2s3.createSynapseWeightGraphOn(layer1, layer2)
      .setCaseDimension(1, 1)
  */

  retinaStream.append(InputAER.DataFromFile(dataFile).repeat(8))
  n2s3.runAndWait()


  println("### Testing ###")

  Layer2WTAconnection.disconnect()
  layer2.fixNeurons()

  //inputLayer.setInput(FreeWay.input("data/aerdata/freeway.mat.dat"))
  retinaStream.append(InputAER.DataFromFile(dataFile))

  /*
  val logs = n2s3.system.actorOf(Props(new NeuronsFireLogText("results/freeway_result")), LocalActorDeploymentStrategy)

  for(neuron <- layer2.neurons){
    neuron.send(Subscribe(NeuronFireEvent, ExternalSender.getReference(logs)))
  }
  */
  n2s3.runAndWait()

  println("### Save results ###")
  /*Await.result(ask(logs, Done)(Config.defaultTimeout), Config.defaultTimeout.duration)

  ImageSynapsesWeight.save(layer1.neurons.map(n => (n.getNetworkAddress, 128, 128)), 4, 1, "freeway.layer1.png")
  ImageSynapsesWeight.save(layer2.neurons.map(n => (n.getNetworkAddress, 1, 60)), 8, 1, "freeway.layer2.png")

  ReconstructSynapsesWeight.save(
    inputLayer.neurons.map { n => n.getNetworkAddress},
    128, 128,
    layer2.neurons.map { n => n.getNetworkAddress},
    4, 1,
    "freeway.all.png")
*/
  println("### End ###")

  n2s3.destroy()
}