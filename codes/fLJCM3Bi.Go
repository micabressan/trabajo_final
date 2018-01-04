package main

import "time"

type agent struct {
	name string
	klobuk int
	input1,input2,output1,output2 chan int


}

var agent1, agent2, agent3 agent;

var agentArray [3]agent

func vidim(name string)(int,int){
	var a,b int;
	a = -1;
	b =-1;
	var i int;
	for i = 0; i < 3; i++ {
		if(agentArray[i].name == name){ continue;}
		if( a == -1){
			a = agentArray[i].klobuk;
		}else{
			b = agentArray[i].klobuk;
		}
	}
	return a,b;
}





func main() {
	// biely =0 , cierny 1
	agent1.name = "Prvy";
	agent1.klobuk = 1;
	agent1.input1 = make(chan int);
	agent1.input2 =  make(chan int);


	agent2.name = "Druhy";
	agent2.klobuk = 0;
	agent2.input1 = make(chan int);
	agent2.input2 =  make(chan int);


	agent3.name = "Treti";
	agent3.klobuk = 1;
	agent3.input1 = make(chan int);
	agent3.input2 =  make(chan int);


	agent1.output1 = agent2.input1
	agent1.output2 = agent3.input1

	agent2.output1 = agent1.input1
	agent2.output2 = agent3.input2

	agent3.output1 = agent1.input2
	agent3.output2 = agent2.input2//

	agentArray[0] = agent1;
	agentArray[1] = agent2;
	agentArray[2] = agent3;


	agenLife(agent3);
	agenLife(agent2);
	agenLife(agent1);


	time.Sleep(10 * time.Second)
}


func agenLife(my agent) {
	go func(){
		var kolo int;
		for kolo = 0; kolo < 3; kolo++ {
			a,b := vidim(my.name);
			if(kolo == 0){
				if(a+b == 2){
					println("1,kolo volam sa ",my.name," a som biely");
					go func(){
						my.output1 <- 1;
					}();
					go func(){
						my.output2 <- 1;
					}();
					return;
				}else{
					ostatny := 0;
					go func(){
						timeEnd :=  time.After(5 * time.Second);
						for {
							select {
							case val := <-my.input1: {
								ostatny+=val;
								break;
							}
							case <-timeEnd:
								break;
							}
						}
					}()
					go func(){
						timeEnd :=  time.After(5 * time.Second);
						for {
							select {
							case val := <-my.input2: {
								ostatny+=val;
								break;
							}
							case <-timeEnd:
								break;
							}
						}
					}()
					time.Sleep(6 * time.Second)
					if(ostatny == 1){
						println("1.kolo volam sa ",my.name," a som cierny");
						return;
					}


				}
			}
			if(kolo ==1 ){
				if(a+b == 1){
					println("2.kolo volam sa ",my.name," a som biely");
					return;
				}
			}
			if(kolo == 2 ){
				println("volam sa ",my.name," a som biely");
			}
			time.Sleep(2000);
		}
	}()
}