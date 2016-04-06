static void init_I2C1(void)
{   
    I2C_InitTypeDef I2C_InitStruct;
    
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_I2C1, ENABLE);
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOB, ENABLE);
    
    GPIO_InitStruct.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_9;
    GPIO_InitStruct.GPIO_Mode = GPIO_Mode_AF;
    GPIO_InitStruct.GPIO_Mode = GPIO_Speed_100MHz;
    
    GPIO_InitStruct.GPIO_Mode = GPIO_OType_OD;
    GPIO_InitStruct.GPIO_Mode = GPIO_PuPd_UP;
    //GPIO_Init(GPIOB, &GPIO_InitStruct);
    
    GPIO_PinAFConfig(GPIOB, GPIO_PinSource8, GPIO_AF_I2C1); // SCL
    GPIO_PinAFConfig(GPIOB, GPIO_PinSource9, GPIO_AF_I2C1); // SDA
    
    GPIO_Init(GPIOB, &GPIO_InitStruct);
    
    I2C_InitStruct.I2C_ClockSpeed = 100000; // 100kHz
    I2C_InitStruct.I2C_Mode = I2C_Mode_I2C; // I2C mode
    I2C_InitStruct.I2C_DutyCycle = I2C_DutyCycle_2; // 50% duty cycle -> standard
    I2C_InitStruct.I2C_OwnAddress1 = 0x00; // own address
    I2C_InitStruct.I2C_Ack = I2C_Ack_Disable; // disable ack when reading
    I2C_InitStruct.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit; // 7 bit address
    
    I2C_Init(I2C1, &I2C_InitStruct); 
    I2C_Cmd(I2C1, ENABLE);


}