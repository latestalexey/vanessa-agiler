﻿
&НаКлиенте
Процедура СкрытьРодителей(Команда)
	ПоказатьПредупреждение(, "Не реализовано.");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовый(ЭлементПроцесса, Родитель) 
	ПараметрыЗаполнения = Новый Структура;
	
	ПараметрыЗаполнения.Вставить("ЭлементПроцесса", ЭлементПроцесса);
	ПараметрыЗаполнения.Вставить("Владелец", Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы[0].ПравоеЗначение);
	ПараметрыЗаполнения.Вставить("Родитель", Родитель);
	
	ПараметрыФормы = Новый Структура;
									 
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ПараметрыЗаполнения);
	
	ОткрытьФорму("Справочник.Процессы.ФормаОбъекта", ПараметрыФормы);
КонецПроцедуры

&НаКлиенте
Процедура Создать_Старт(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.Старт"), Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура Создать_Завершение(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.Завершение"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура Создать_ПользовательскаяИстория(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.ПользовательскаяИстория"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура Создать_Условие(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.Условие"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура Создать_ВариантУсловия(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.ВариантУсловия"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура Создать_ВложенныйПроцесс(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.ВложенныйПроцесс"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура Создать_Комментарий(Команда)
	СоздатьНовый(ПредопределенноеЗначение("Перечисление.ЭлементыПроцесса.Комментарий"), Элементы.Список.ТекущаяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "УстановитьКурсорНаНовыйЭлементПроцесса" Тогда
		Элементы.Список.ТекущаяСтрока = Параметр;
	КонецЕсли;
КонецПроцедуры
