procedure FromAdditionalCode(AdditCode: string);
var
  k, i, AdditCodeInt: int64;
  
  DecimalNegativeNumber: real;

begin
  for i:= 1 to length(AdditCode) do
  if (AdditCode[i]<>'1') and (AdditCode[i]<>'0') then begin
  writeln('Перепроверьте правильность ввода дополнительного кода.');
  exit;
  end;
  
  // Переворачиваем снова число (инвертируем его)
  for i := 1 to length(AdditCode) do
    if AdditCode[i] = '1' then AdditCode[i] := '0'
    else AdditCode[i] := '1';
  writeln('Дополнительный код после инвертации: ', AdditCode); 
   //добавляем единицу
  for i := length(AdditCode) downto 1 do
    if AdditCode[i] = '1' then
      AdditCode[i] := '0'
      else
    begin
      AdditCode[i] := '1';
      break;
    end;
  
  writeln('Модуль отрицательного числа ', AdditCode);
  
  // Переводим сам инвертированный код обратно в десятичную СС
  
  AdditCodeInt := strtoint64(AdditCode);//перевод строки в число
  k := 0;
  DecimalNegativeNumber := 0;
  while AdditCodeInt > 0 do
  begin
    DecimalNegativeNumber := DecimalNegativeNumber + (AdditCodeInt mod 10) * power(2, k);
    k := k + 1;
    AdditCodeInt := AdditCodeInt div 10;
  end;
  writeln('исходное число: ', '-', DecimalNegativeNumber);//результат
end;


var
  AdditCode: string;

begin
  write('Введите дополнительный код числа ');
  read(AdditCode);
  FromAdditionalCode(AdditCode);
end.