Program Pr;
var input: file of char;                                                        //������ ������. 
    DataST: string;                                                             //������ ��� ������� ����.
    BufChar: char;                                                              //������ ��� ������������� ������.
    Loop: integer;                                                              //���������� ���.
    BufNOT: byte;                                                               //�������� ��� ����� ����/������� ����.
    MESNOT: array [0..5000, 0..1] of byte;                                      //������ �� 5000 ���.
    I: integer;                                                                 //�������-����������.
Begin
    assign(input, 'INPUT.txt'); reset(input);                                   //���������� ���� ��� ������.
    Loop:=0;
    while not Eof(input) do                                                     //������ �� ��������� �����.
    Begin
      DataST:='';
      while 1=1 do                                                              //������ �� �������.
      Begin 
        read(input, BufChar);                                                   //������ ������.
        if (BufChar <> ' ') then DataST:=DataST+BufChar                         //���� �� ������ ������ - ��������.
        else break;                                                             //����� - �����.
      End;

    case DataST[1] of                                                           //��������� ����.
    'C': if (DataST[2] = 'i') then Begin                                        //���� ���� ��, �� ������� �� #.                                                                    
         if      (DataST[4] = '1') then BufNOT:=1                               //��# - �����  ������. 
         else if (DataST[4] = '2') then BufNOT:=13                              //��# - ������ ������. 
         else if (DataST[4] = '3') then BufNOT:=25                              //��# - ������ ������.
         End else Begin              
         if      (DataST[2] = '1') then BufNOT:=0                               //��  - ����� ������.
         else if (DataST[2] = '2') then BufNOT:=12                              //��  - ������ ������. 
         else if (DataST[2] = '3') then BufNOT:=24 End;                         //��  - ������ ������.   
         
    'D': if      (DataST[2] = 'i') then Begin                                   //���� ���� ��.                                                                   
         if      (DataST[4] = '1') then BufNOT:=3                              
         else if (DataST[4] = '2') then BufNOT:=15                             
         else if (DataST[4] = '3') then BufNOT:=27
         End else Begin
         if      (DataST[2] = '1') then BufNOT:=2                             
         else if (DataST[2] = '2') then BufNOT:=14                             
         else if (DataST[2] = '3') then BufNOT:=26 End;                   
          
    'E': if      (DataST[2] = '1') then BufNOT:=4                               //���� ���� �� (����� "�� �����").                    
         else if (DataST[2] = '2') then BufNOT:=16                    
         else if (DataST[2] = '2') then BufNOT:=28;    
         
    'F': if      (DataST[2] = 'i') then Begin                                   //���� ���� ��.                                                                   
         if      (DataST[4] = '1') then BufNOT:=6                              
         else if (DataST[4] = '2') then BufNOT:=18                             
         else if (DataST[4] = '3') then BufNOT:=30 End 
         else Begin
         if      (DataST[2] = '1') then BufNOT:=5                            
         else if (DataST[2] = '2') then BufNOT:=17                             
         else if (DataST[2] = '3') then BufNOT:=29 End; 
         
    'G': if      (DataST[2] = 'i') then Begin                                   //���� ���� ����.                                                                   
         if      (DataST[4] = '1') then BufNOT:=8                           
         else if (DataST[4] = '2') then BufNOT:=20                             
         else if (DataST[4] = '3') then BufNOT:=32 End 
         else Begin
         if      (DataST[2] = '1') then BufNOT:=7                           
         else if (DataST[2] = '2') then BufNOT:=19                           
         else if (DataST[2] = '3') then BufNOT:=31 End; 
         
    'A': if      (DataST[2] = 'i') then Begin                                   //���� ���� ��.                                                                   
         if      (DataST[4] = '1') then BufNOT:=10                             
         else if (DataST[4] = '2') then BufNOT:=22                            
         else if (DataST[4] = '3') then BufNOT:=34 End 
         else Begin
         if      (DataST[2] = '1') then BufNOT:=9                             
         else if (DataST[2] = '2') then BufNOT:=21                             
         else if (DataST[2] = '3') then BufNOT:=33 End; 
         
    'B': if      (DataST[2] = '1') then BufNOT:=11                              //��.              
         else if (DataST[2] = '2') then BufNOT:=23                    
         else if (DataST[2] = '2') then BufNOT:=35;  
    'P': BufNOT:=36;                                                            //� ������ "�����".
    End;
    
    MESNOT[Loop][0]:=BufNOT;                                                    //��������� ����� ����. 
    
    if (DataST[length(DataST)-1] <> '.') then                                   //��������� ������������ ���� "��� �����" (� ������������).
      case DataST[length(DataST)-1] of 
      '1': BufNOT:=16;
      '2': BufNOT:=8;
      '4': BufNOT:=4;
      '8': BufNOT:=2;
      end
    else 
      case DataST[length(DataST)-2] of                                          //������������ ���� � ������ (� ������������).
      '1': BufNOT:=20;
      '2': BufNOT:=12;
      '4': BufNOT:=6;
      '8': BufNOT:=3;
      end;    
    
    MESNOT[Loop][1]:=BufNOT;                                                    //��������� ������������. 
    
    Loop:=Loop+1;
    End;
    
    writeln ('//������ ���.');                                                  //���������� ������.
    write('uint8_t MusicNote [', Loop+1, '][2] = {');
    for I:=0 to Loop-1 do Begin write(MESNOT[I][0], ',', MESNOT[I][1]);
                              if (I<>(Loop-1)) then write(', ');
                        End;
    write('};');
    
End.