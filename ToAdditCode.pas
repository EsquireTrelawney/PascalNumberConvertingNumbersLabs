procedure AdditionalCode(NegativeNumber: int64);
var
  PowerOfTen, AmmountOfZeros, AmmountOfDigits, i, ConversedNumber, AbsNumber: int64; 
  // степень десятки, кол-во нулей, кол-во разрядов, i, ПереведённоеЧисло, Модуль числа
  NumberWithZeros: string; 
  // не знал,как назвать переменную,но по сути она будет хранить переведённое число 
  // ... с приписанными в начале незначащими нулями
  

begin
  if (NegativeNumber >= 0) or (NegativeNumber<-524287) then begin
    writeln('Введено некорректное число.');
    exit;
  end;
  AbsNumber := abs(NegativeNumber);
  
  // задаём кол-во разрядов. По умолчанию - 8. 0000 0000, если число до 127 включительно
  AmmountOfDigits := 8;
  // ... иначе 16 "битов"
  if AbsNumber > 128 then AmmountOfDigits := 16;
  // ... иначе 32 разряда
  if AbsNumber > 32768 then AmmountOfDigits := 32;
  
  
  // Перевод числа в двоичную систему по стандартному алгоритму
  PowerOfTen := 1;
  ConversedNumber := 0;
  while AbsNumber > 0 do
  begin
    ConversedNumber := ConversedNumber + (AbsNumber mod 2) * PowerOfTen;
    PowerOfTen := PowerOfTen * 10;
    AbsNumber := AbsNumber div 2;
  end;
    //добавляем несущественные нули, сначала преобразовав число в строку
  str(ConversedNumber, NumberWithZeros); 
  AmmountOfZeros := AmmountOfDigits - length(NumberWithZeros);
  
  if AmmountOfZeros <> 0 then
    repeat
      NumberWithZeros := '0' + NumberWithZeros;
      dec(AmmountOfZeros); // то же самое, что и AmmountOfZeros := AmmountOfZeros - 1;
    until AmmountOfZeros = 0;
    
  writeln('Исходное число ', NegativeNumber, ' в системе счисления с основанием "2": ', NumberWithZeros);
  
  // Переворачиваем число (инвертируем его)
  for i := 1 to length(NumberWithZeros) do
    if NumberWithZeros[i] = '1' then NumberWithZeros[i] := '0'
    else NumberWithZeros[i] := '1';
    // т.е. если в числе встречена в опред разряде "1", она становится "0" и наоборот
  writeln('Число ', NegativeNumber, ' имеет следующий обратный код:', NumberWithZeros); 
  
  // сам алгоритм перевода в доп. код
  for i := length(NumberWithZeros) downto 1 do
    if NumberWithZeros[i] = '1' then
      NumberWithZeros[i] := '0'
      else
    begin
      NumberWithZeros[i] := '1';
      break;
    end;
  writeln('Число ', NegativeNumber, ' имеет следующий дополнительный код: ', NumberWithZeros);
end;


var
  NegativeNumber: int64;

begin
  write('Введите отрицательное число в десятичной системе счисления: ');
  read(NegativeNumber);
  AdditionalCode(NegativeNumber);
end.