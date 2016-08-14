﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Если ВыгрузкаИнициированаИзФормыЭлемента(ПараметрыВыполненияКоманды) Тогда
		ВыгрузитьИзФормыЭлемента(ПараметрКоманды);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ВыгрузкаИнициированаИзФормыЭлемента(ПараметрыВыполненияКоманды) 
	Результат = СтрНайти(ПараметрыВыполненияКоманды.Источник.ИмяФормы, "ФормаЭлемента") > 0;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ВыгрузитьИзФормыЭлемента(ТекущийЭлемент)
	ИмяFeatureФайла = ОбщегоНазначениеСервер.ПолучитьЗначениеРеквизита("Справочник", "ПользовательскиеИстории", ТекущийЭлемент, "ИмяFeatureФайла");
	
	Файл = Новый Файл(ИмяFeatureФайла);
	
	Файл.НачатьПроверкуСуществования(Новый ОписаниеОповещения("ПроверкаСуществованияFeatureФайлаЗавершение", ЭтотОбъект, ТекущийЭлемент));
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаСуществованияFeatureФайлаЗавершение(Существует, ТекущийЭлемент) Экспорт
	Если Существует Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Фича уже есть, а функционала синхронизации пока нет)))";
		Сообщение.Сообщить();	

		Возврат;
	КонецЕсли;

	ПутьКFeatureФайлу = ОбщегоНазначениеСервер.ПолучитьПутьКFeatureФайлу(ТекущийЭлемент);

	ШаблонФичи = ОбщегоНазначениеКлиент.ПолучитьШаблонФичи();
	
	НетОшибок = Истина;
	ЗаполнитьШаблон(ТекущийЭлемент, ШаблонФичи, НетОшибок);
	
	Если НетОшибок Тогда
		ТекстовыйДокумент = Новый ТекстовыйДокумент;
		
		ТекстовыйДокумент.УстановитьТекст(ШаблонФичи);
		
		ТекстовыйДокумент.НачатьЗапись(Новый ОписаниеОповещения("ВыгрузитьИзФормыЭлементаЗавершение", ЭтотОбъект), ПутьКFeatureФайлу, КодировкаТекста.UTF8);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьИзФормыЭлементаЗавершение(ЗаписанУспешно, ДополнительныеПараметры) Экспорт
	Если ЗаписанУспешно Тогда
		Оповестить("ПодсветитьИмяFeatureФайла");		
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьШаблон(ТекущийЭлемент, ШаблонФичи, НетОшибок)
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПользовательскиеИстории.НомерIssue,
	|	ПользовательскиеИстории.Наименование КАК Заголовок,
	|	ПользовательскиеИстории.Роль,
	|	ПользовательскиеИстории.КлючевоеДействие,
	|	ПользовательскиеИстории.НеобходимыйФункционал
	|ИЗ
	|	Справочник.ПользовательскиеИстории КАК ПользовательскиеИстории
	|ГДЕ
	|	ПользовательскиеИстории.Ссылка = &Ссылка
	|	И НЕ ПользовательскиеИстории.НомерIssue = 0";
	
	Запрос.УстановитьПараметр("Ссылка", ТекущийЭлемент);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		НетОшибок = Ложь;
		
		Возврат;
	КонецЕсли;

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ВыборкаДетальныеЗаписи.Следующий();

	ШаблонФичи = СтрЗаменить(ШаблонФичи, "#НомерIssue", XMLСтрока(ВыборкаДетальныеЗаписи.НомерIssue));
	ШаблонФичи = СтрЗаменить(ШаблонФичи, "#Заголовок", ВыборкаДетальныеЗаписи.Заголовок);
	ШаблонФичи = СтрЗаменить(ШаблонФичи, "#Роль", ВыборкаДетальныеЗаписи.Роль);
	ШаблонФичи = СтрЗаменить(ШаблонФичи, "#КлючевоеДействие", ВыборкаДетальныеЗаписи.КлючевоеДействие);
	ШаблонФичи = СтрЗаменить(ШаблонФичи, "#НеобходимыйФункционал", ВыборкаДетальныеЗаписи.НеобходимыйФункционал);
КонецПроцедуры
