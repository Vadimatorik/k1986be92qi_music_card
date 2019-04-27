Program Sin_wav_Gener;
Var DAC_CLK: word;                             //������� ����� ������ DAC.
    Loop:    word;                             //����������� ��������� � �����.
    PR:      real;                             //������ �����.
    I:       word;                             //�������.
    ISIN:    byte;                             //������� ������ �����.
    GR:      byte;                             //��������� �����.
    MesVoln: array [0..100000] of integer;     //������ �������� ��� �����.
    MesSM:   array [0..35] of word;            //��������. 
    MesKOL:  array [0..35] of word;            //����������� � �����.
    
const SinTON: array [0..35] of real = 
      (130.82,  138.59, 147.83, 155.56, 164.81, 174.62, 185,    196,    207,   
       220,     233.08, 246.96, 261.63, 277.18, 293.33, 311.13, 329.63, 349.23,
       369.99,  392,    415.30, 440,    466.16, 493.88, 523.25, 554.36, 587.32,
       622.26,  659.26, 698.46, 739.98, 784,    830.60, 880,    932.32, 987.75);
 
Begin
  Loop := 0;                                       //����� ����������� ���������� ������.
  write('������� ����� DAC: '); readln(DAC_CLK);   //�������� ������� ����� DAC.
  write('������� ��������� (1..50): '); readln(GR);//��������� �����.
  for ISIN:=0 to 35 do                             //���������� ������� ��� ���� 36 ���.
  Begin
    PR:=DAC_CLK/SinTON[ISIN]/2;                    //�������� ������ �����.  
    MesSM[ISIN]:=Loop;                             //��������.
    MesKOL[ISIN]:=Round(PR*2)+1;                   //����������� ��������� � �����.
    for I:=0 to Round(PR*2) do                     //������� �����.
      Begin
        MesVoln[Loop]:=Round(GR+GR*sin(I*pi/PR));
        Loop:=Loop+1;
      End;
  End;
  
  writeln('//����������� ��������� � ��������� ����� 0..35.');
  write('const uint16_t MesKOL [36] = {');
  for I:=0 to 35 do 
  Begin
    write(MesKOL[I]);
    if (I <> 35) then write (', ');
  End;
  writeln('};');
 
  writeln('//�������� ������� �������� ������� 0..35.');
  write('const uint16_t MesSM [36] = {');
  for I:=0 to 35 do 
  Begin
    write(MesSM[I]);
    if (I <> 35) then write (', ');
  End;
  writeln('};');
  
  writeln('//������ �������� ������.');
  write('const uint8_t SinMES [', Loop+1, '] = {');
  for I:=0 to Loop-1 do 
  Begin
    write(MesVoln[I]);
    if (I <> Loop-1) then write (', ');
  End;
  writeln('};');
End.


