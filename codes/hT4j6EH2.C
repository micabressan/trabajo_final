//Dactyl project v1.0

volatile uint32_t Jobs;			//jobs is a bitfield of outstanding i2c jobs - set bit indicates job needs to be done
const uint8_t Tasks[NUMBER_I2C_TASKS]=I2C_TASKS;//task list is in flash, MSNibble of each task byte -> job number, LSN -> I2C task
const uint8_t Sentbytes[NUMBER_I2C_TASKS]=I2C_SENTBYTES;//this is the send data


/**

  * @brief  This function handles I2C1 Event interrupt request.

  * @param  None

  * @retval : None

  */

void I2C1_EV_IRQHandler(void)
{
	static uint8_t tasklistpointer,i2cdir;	//stores the current position in the tasklist - the list of individual i2c tasks
	__IO uint32_t SR1Register =I2C1->SR1;

	__IO uint32_t SR2Register =I2C1->SR2;
	/* If SB = 1, I2C1 master sent a START on the bus: EV5) */

	if ((SR1Register &0x0001) == 0x0001) {

        	/* Send the slave address for transmssion or for reception (according to the configured value

        	    in the write master write array) */

        	I2C1->DR = Sentbytes[tasklistpointer];

        	SR1Register = 0;

        	SR2Register = 0;
		i2cdir=Sentbytes[tasklistpointer++]&0x01;//set the direction using the read/write bit and intrement to next task

 	}
	/* If I2C1 is Master (MSL flag = 1) */

	if ((SR2Register &0x0001) == 0x0001) {

		/* If ADDR = 1, EV6/8_1 : slave achnowledged*/

		if ((SR1Register &0x0002) == 0x0002) {
			I2C1->CR2 |= (uint16_t)I2C_IT_BUF;//enable the TXE/RXNE interrupts
			if(TXDIR==i2cdir)/*EV8_1 is here*/

                		/* Write the first data in the data register */

                		I2C1->DR = Sentbytes[tasklistpointer++];
			else if (IGNOREBYTE==Tasks[tasklistpointer]&0x0F) {//EV6_1
				/* Clear ACK */

                		I2C1->CR1 &= CR1_ACK_Reset;
				I2C1->CR2 &= (uint16_t)~I2C_IT_BUF;//also disable RXNE
				tasklistpointer++;
			}
			else/* Set ACK to ack following RX bytes */
               			I2C1->CR1 |= CR1_ACK_Set;
		}
		else if ((SR1Register &0x0080) == 0x0080) {//TXE : events EV8/8_2 are here
			if ((SR1Register &0x0004) == 0x0004) {// event EV8_2 - program a STOP or (Repeated) START
				if(SENDSTOP==Tasks[tasklistpointer]&0x0F)
					/* Program the STOP */

                			I2C1->CR1 |= CR1_STOP_Set;
				else//SENDSTART
					/* Program the START */
					I2C1->CR1 |= CR1_START_Set;
				tasklistpointer++;//move onto the next task
			}
			else {// event EV8 - load a byte if there is more data to send
				if(SENDBYTE==Tasks[tasklistpointer]&0x0F)//send a byte task - otherwise we dont load and cause a STOP
					I2C1->DR = Sentbytes[tasklistpointer++];
				else// disable the TXE interrupt so we only have EV8_2 once the buffer is flushed
					I2C1->CR2 &= (uint16_t)~I2C_IT_BUF;
			}
		}		
		else if ((SR1Register &0x0040) == 0x0040) {//RXNE : events EV7/7_2 are here
			if ((SR1Register &0x0004) == 0x0004) {// event EV7_2/EV7_3 - program a STOP
				if(!(I2C1->CR1 | CR1_ACK_Set)) {// event EV7_3
					/* Program the STOP */

                			I2C1->CR1 |= CR1_STOP_Set;
					Receivedbytes[tasklistpointer-1] = I2C1->DR;//N-2 byte and increment to final byte
					Receivedbytes[tasklistpointer++] = I2C1->DR;//N-1 byte
				}
				else {//event EV7_2
               				/* Clear ACK */

                			I2C1->CR1 &= CR1_ACK_Reset;
					Receivedbytes[tasklistpointer-1] = I2C1->DR;//N-2 byte
					/* Program the STOP */

                			I2C1->CR1 |= CR1_STOP_Set;
					Receivedbytes[tasklistpointer++] = I2C1->DR;//N-1 byte and increment to final byte
					I2C1->CR2 |= (uint16_t)I2C_IT_BUF;//enable the TXE/RXNE interrupts
				}
			}
			else {// event EV7 - read a byte into the received bytes array
				if(RECEIVEBYTE==Tasks[tasklistpointer]&0x0F) //Receive a byte
					Receivedbytes[tasklistpointer++] = I2C1->DR;
				else if(IGNOREBYTE==Tasks[tasklistpointer]&0x0F) {//Dont do anything - use this to fill up buffer
					tasklistpointer++;//move onto the next task
					I2C1->CR2 &= (uint16_t)~I2C_IT_BUF;//disable the RXNE/TXE interrupt
				}
			}
		}
	}
	uint8_t oldtask=tasklistpointer++;//Move onto the next task, save current task number (this will be task number after servicing)
	if(tasklistpointer==NUMBER_I2C_TASKS)//looked through all the tasks? - loop around
		tasklistpointer=0;
	if((Tasks[tasklistpointer]&0xF0)!=(Tasks[oldtask]&0xF0))//Did we pass a jobs boundary in the tasks list?
		Jobs&=~1<<((Tasks[tasklistpointer]&0xF0)>>4);//Mark off the task bit as completed
	if(!Jobs) {			//No Jobs! We appear to have reached One Infinite Loop CA
		tasklistpointer=0;	//set the tasklist to zero
		return void;		//quit as we have completed all the jobs for now
	}
	else {
		while(!((Jobs>>((Tasks[tasklistpointer]&0xF0)>>4))&0x00000001)) {
			tasklistpointer++;	//loop through the task list until we find a job that need completing
			if(tasklistpointer==NUMBER_I2C_TASKS)//looked through all the tasks - loop around (wont loop forever as Jobs!=0)
				tasklistpointer=0;
		I2C1->CR1 |= CR1_START_Set;//send the start for the new job - this will kickstart the first interrupt
		}
	}
}