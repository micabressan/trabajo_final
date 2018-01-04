package cp

import JaCoP.core.IntVar
import JaCoP.scala._

object projectPFLC extends jacop {


  def main(args: Array[String]): Unit = {

    //val csv = getClass.getResource("newStudentResult.csv")
    //val csv = getClass.getResource("bloc1OKResult.csv")
    //val csv = getClass.getResource("bloc2OKResult.csv")
    val csv = getClass.getResource("nolan2Result.csv")
    //val csv = getClass.getResource("random1Result.csv")


    println("En cours d'importation des informations de l'etudiant")
    println("Format attendu du csv, avec une ligne header : cours, bloc, poids, corequis, prerequis, quadrimestre, continue, stage, reussi")
    var nbrCourse = 0

    //Definir listes from csv
    var cours = List[String]()
    var bloc = List[Int]()
    var poids = List[Int]()
    var coRequis = List[List[Int]]()
    var preRequis = List[List[Int]]()
    var quadri = List[Int]() // the value is 3 when both
    var stage = List[Boolean]()
    var continue = List[Boolean]()
    var coursReussis = List[Boolean]()

    var quadriBloque = List[Boolean](false, false, false)
    val bufferedSource = io.Source.fromURL(csv)("UTF-8")
    for (line <- bufferedSource.getLines.drop(1)) {
      val Array(coursCSV, blocCSV, poidsCSV, coRequisCSV, preRequisCSV, quadriCSV, continueCSV, stageCSV, reussiCSV) = line.split(";").map(_.trim)
      nbrCourse += 1
      cours = cours :+ coursCSV.toString
      bloc = bloc :+ blocCSV.toInt
      poids = poids :+ poidsCSV.toInt
      coRequis = coRequis :+ coRequisCSV.split(",").map(_.trim).map { case d => d.toInt }.toList
      preRequis = preRequis :+ preRequisCSV.split(",").map(_.trim).map { case d => d.toInt }.toList
      quadri = quadri :+ quadriCSV.toInt
      stage = stage :+ stageCSV.toBoolean
      continue = continue :+ continueCSV.toBoolean
      coursReussis = coursReussis :+ reussiCSV.toBoolean
    }
    bufferedSource.close

    //Definir Var dynamiques
    val coursPris = for (i <- List.range(0, nbrCourse)) yield BoolVar(cours(i))
    val poidsPris = for (i <- List.range(0, nbrCourse)) yield IntVar(cours(i), 0, poids.sum)
    val poidsMax = IntVar("Poids max", 0, poids.sum)
    val coursEstPris = BoolVar("coursPris")

    val quadriBloque1 = for (i <- List.range(0, nbrCourse)) yield BoolVar(cours(i))
    val quadriBloque2 = for (i <- List.range(0, nbrCourse)) yield BoolVar(cours(i))
    val maxBloqueQ1 = IntVar("mbq1",0,1)
    val maxBloqueQ2 = IntVar("mbq2",0,1)
    for (i <- List.range(0, nbrCourse)){
      if((stage(i) || continue(i))){
        if(quadri(i) == 1 || quadri(i) == 3)
          OR(AND(quadriBloque1(i) #=1, coursPris(i) #= 1),AND(quadriBloque1(i) #=0, coursPris(i) #= 0))
        if(quadri(i) == 2 || quadri(i) == 3)
          OR(AND(quadriBloque2(i) #=1, coursPris(i) #= 1),AND(quadriBloque2(i) #=0, coursPris(i) #= 0))
      }else{
        quadriBloque1(i) #= 0
        quadriBloque2(i) #= 0
      }
    }
    sum(quadriBloque1) #<= 1
    sum(quadriBloque2) #<= 1



    //CAS TRIVIAUX - DEBUT
    //Moins de 45 ECTS bloc 1 = Finir bloc 1
    var poidsReussiBloc1 = 0
    for (i <- List.range(0, nbrCourse)) {
      if (bloc(i) == 1 && coursReussis(i))
        poidsReussiBloc1 += poids(i)
    }
    if (poidsReussiBloc1 < 45) {
      println("Cas -45ECT bloc1")
      return
    }
    //FIN 45-ECTS

    //Plus de 120 ECTS allBlocs = Tout finir
    var poidsReussiAllBlocs = 0
    for (i <- List.range(0, nbrCourse)) {
      if (coursReussis(i))
        poidsReussiAllBlocs += poids(i)
    }
    if (poidsReussiAllBlocs > 120) {
      println("Cas +120ECT allBlocs")
      return
    }
    //FIN 120+ECTS

    //bloc 1 fini normalement
    var bloc1ReussiNormalement = true
    for (i <- List.range(0, nbrCourse)) {
      if ((coursReussis(i) && bloc(i) > 1) ||
        (!coursReussis(i) && bloc(i) <= 1))
        bloc1ReussiNormalement = false
    }
    if (bloc1ReussiNormalement) {
      println("Cas bloc 1 reussi normalement")
      return
    }
    //FIN bloc1_OK

    //bloc 2 fini normalement
    var bloc2ReussiNormalement = true
    for (i <- List.range(0, nbrCourse)) {
      if ((coursReussis(i) && bloc(i) > 2) ||
        (!coursReussis(i) && bloc(i) <= 2))
        bloc2ReussiNormalement = false
    }
    if (bloc2ReussiNormalement) {
      println("Cas bloc 2 reussi normalement")
      return
    }
    //FIN bloc2_OK
    //CAS TRIVIAUX - FIN


    //CAS A CONTRAINTES - DEBUT

    //Contrainte : Si total poids validee inf ? 120, min 45 ECT
    var poidsReussi = 0
    for (i <- List.range(0, nbrCourse)) {
      if (coursReussis(i))
        poidsReussi += poids(i)
    }

    // Contrainte : Doit prendre 60+ects si non annee diplomante
    if (poidsReussi < 120) poidsMax #>= 60

    for (i <- List.range(0, nbrCourse)) {

      // Contrainte : Ne peut ?tre pris si reussi
      if (coursReussis(i)) {
        coursPris(i) #= 0
      }

      // Contraite : Ne peut proposer un programme de plus de 75 ects
      poidsMax #<= 75

      // Contrainte : Si pris + quadri libre, poids assigne. Si non pris, poids non assigne.
      OR(
        AND(coursPris(i) #= 1, poidsPris(i) #= poids(i)),
        AND(coursPris(i) #= 0, poidsPris(i) #= 0)
      )

      // Contrainte : pre-requis doit etre valide
      for (j <- preRequis(i)) {
        if (j != 0) { //j==0 <=> pas de pre-requis
          if (!coursReussis(j - 1))
            coursPris(i) #= 0
        }
      }

      // Contrainte : co-requis doit etre valide ou pris
      for (j <- coRequis(i)) {
        if (j != 0) { //j==0 <=> pas de co-requis
          if (!coursReussis(j - 1)) {
            OR(AND(coursPris(i) #= 1, coursPris(j - 1) #= 1),coursPris(j-1) #= 0)
          }
        }
      }

      // Contrainte : continue/stage = quadrimestre bloque


      // List of cont/stage as IntVar{0?3}.
      // Try to match a cont/stage with each quadri
      if (continue(i) || stage(i)) {
        if(quadri(i) == 1){
        }else if(quadri(i) == 2){

        }else if(quadri(i) == 3){

        }
      }
      /*
                if (quadri(i)-1 == 0) quadriBloque = quadriBloque.updated(0, true)
                else if (quadri(i)-1 == 1) quadriBloque = quadriBloque.updated(1, true)
                else if (quadri(i)-1 == 2) {
                  quadriBloque = quadriBloque.updated(0, true)
                  quadriBloque = quadriBloque.updated(1, true)
                  quadriBloque = quadriBloque.updated(2, true)
                }
              }
              */


    }
    /*
            OR(
              AND(quadriBloqueBV(quadri(i)-1)#=1, coursPris(i) #= 0),
              AND(coursPris(i) #= 1, quadriBloqueBV(quadri(i)-1) #= 1),

              AND(coursPris(i) #= 1,
                quadriBloqueBV(0) #= 1,
                quadriBloqueBV(1) #= 1,
                quadriBloqueBV(2) #= 1)

            )
    */
    // ?
    sum(poidsPris, poidsMax)

    def printSol(): Unit = {
      var poidsTotal = 0
      for (v <- poidsPris.filter(_.value != 0)) {
        println(v.id + ". poids : " + v.value + " ")
        poidsTotal += v.value
      }
      println("Poids total du programme : " + poidsTotal)
      println("\n##########\n")
    }

    //val result = satisfy(search_split(coursPris, most_constrained), printSol)
    val result = satisfyAll(search_split(coursPris, most_constrained), printSol)
    //CAS A CONTRAINTES - FIN
  }
}