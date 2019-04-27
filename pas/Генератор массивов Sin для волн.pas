Program Sin_wav_Gener;
Var DAC_CLK: word;                             //Частота смены данных DAC.
    Loop:    word;                             //Колличество элементов в волне.
    PR:      real;                             //Период волны.
    I:       word;                             //Счетчик.
    ISIN:    byte;                             //Счетчик номера волны.
    GR:      byte;                             //Громкость волны.
    MesVoln: array [0..100000] of integer;     //Массив значений для волны.
    MesSM:   array [0..35] of word;            //Смещение. 
    MesKOL:  array [0..35] of word;            //Колличество в блоке.
    
const SinTON: array [0..35] of real = 
      (130.82,  138.59, 147.83, 155.56, 164.81, 174.62, 185,    196,    207,   
       220,     233.08, 246.96, 261.63, 277.18, 293.33, 311.13, 329.63, 349.23,
       369.99,  392,    415.30, 440,    466.16, 493.88, 523.25, 554.36, 587.32,
       622.26,  659.26, 698.46, 739.98, 784,    830.60, 880,    932.32, 987.75);
 
Begin
  Loop := 0;                                       //Общее колличество занимаемой памяти.
  write('Частота смены DAC: '); readln(DAC_CLK);   //Получаем частоту смены DAC.
  write('Введите громкость (1..50): '); readln(GR);//Громкость волны.
  for ISIN:=0 to 35 do                             //Генерируем массивы для всех 36 нот.
  Begin
    PR:=DAC_CLK/SinTON[ISIN]/2;                    //Получаем период волны.  
    MesSM[ISIN]:=Loop;                             //Смещение.
    MesKOL[ISIN]:=Round(PR*2)+1;                   //Колличество элементов в блоке.
    for I:=0 to Round(PR*2) do                     //Считаем волну.
      Begin
        MesVoln[Loop]:=Round(GR+GR*sin(I*pi/PR));
        Loop:=Loop+1;
      End;
  End;
  
  writeln('//Колличество элементов в синусоиде номер 0..35.');
  write('const uint16_t MesKOL [36] = {');
  for I:=0 to 35 do 
  Begin
    write(MesKOL[I]);
    if (I <> 35) then write (', ');
  End;
  writeln('};');
 
  writeln('//Смещение первого элемента массива 0..35.');
  write('const uint16_t MesSM [36] = {');
  for I:=0 to 35 do 
  Begin
    write(MesSM[I]);
    if (I <> 35) then write (', ');
  End;
  writeln('};');
  
  writeln('//Выдаем основной массив.');
  write('const uint8_t SinMES [', Loop+1, '] = {');
  for I:=0 to Loop-1 do 
  Begin
    write(MesVoln[I]);
    if (I <> Loop-1) then write (', ');
  End;
  writeln('};');
End.


