#include "main.h"
#define HCLK_MY_TIMDEL 8000000/100
uint32_t music_books[37] = 
{
    HCLK_MY_TIMDEL/130.82,                         //C_3
    HCLK_MY_TIMDEL/138.59,
    HCLK_MY_TIMDEL/147.83,
    HCLK_MY_TIMDEL/155.56,
    HCLK_MY_TIMDEL/164.81,
    HCLK_MY_TIMDEL/174.62,
    HCLK_MY_TIMDEL/185,
    HCLK_MY_TIMDEL/196,
    HCLK_MY_TIMDEL/207,
    HCLK_MY_TIMDEL/220,
    HCLK_MY_TIMDEL/233.08,
    HCLK_MY_TIMDEL/246.96,
    
    HCLK_MY_TIMDEL/261.63,                          //C_4
    HCLK_MY_TIMDEL/277.18, 
    HCLK_MY_TIMDEL/293.33, 
    HCLK_MY_TIMDEL/311.13, 
    HCLK_MY_TIMDEL/329.63, 
    HCLK_MY_TIMDEL/349.23, 
    HCLK_MY_TIMDEL/369.99,
    HCLK_MY_TIMDEL/392,
    HCLK_MY_TIMDEL/415.30,
    HCLK_MY_TIMDEL/440,
    HCLK_MY_TIMDEL/466.16,
    HCLK_MY_TIMDEL/493.88,
    
    HCLK_MY_TIMDEL/523.25,                          //C_5
    HCLK_MY_TIMDEL/554.36, 
    HCLK_MY_TIMDEL/587.32,
    HCLK_MY_TIMDEL/622.26,
    HCLK_MY_TIMDEL/659.26,
    HCLK_MY_TIMDEL/698.46,
    HCLK_MY_TIMDEL/739.98,
    HCLK_MY_TIMDEL/784,
    HCLK_MY_TIMDEL/830.60,
    HCLK_MY_TIMDEL/880,
    HCLK_MY_TIMDEL/932.32,
    HCLK_MY_TIMDEL/987.75,
    0                                             //Пауза             
};

uint8_t Play_museic [30][2] = {18,2, 25,2, 20,6, 21,2, 21,4, 18,2, 25,2, 20,6, 21,2, 23,2, 21,2, 18,8, 36,2, 20,2, 16,2, 14,2, 16,8, 36,2, 18,2, 14,2, 13,2, 14,2, 16,2, 18,6, 20,2, 21,2, 23,2, 21,8, 20,4};
	
int main (void)
{
  HSE_Clock_ON();                                  //Разрешаем использование HSE генератора. 
  HSE_Clock_OffPLL();                              //Настраиваем "путь" сигнала и включаем тактирование от HSE генератора.
  Buzzer_out_DAC_init();                           //Настраиваем порт для ЦАП.
  DAC_Init();                                      //Настраиваем ЦАП.
  DMA_to_DAC_and_TIM1();                           //Настраиваем DMA для работы с DAC2 через таймер 1.
  Init_TIMER1_to_DMA_and_DAC2();                   //Настраиваем таймер 1.
  Init_SysTick();
  while (1) 
        {                    
           for (uint32_t PL = 0; PL < sizeof(Play_museic)/2; PL++)
            {
                SM_Ton(music_books[Play_museic[PL][0]]); 			
                Delay(Play_museic[PL][1]);
            }
        }
}