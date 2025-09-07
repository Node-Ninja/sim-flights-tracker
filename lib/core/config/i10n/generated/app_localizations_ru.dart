// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get network => 'Сеть';

  @override
  String get flights => 'Рейсы';

  @override
  String get controllers => 'Диспетчеры';

  @override
  String get observers => 'Наблюдатели';

  @override
  String get home => 'Главная';

  @override
  String get map => 'Карта';

  @override
  String get menu => 'Меню';

  @override
  String get altitude => 'Высота';

  @override
  String get speed => 'Скорость';

  @override
  String get heading => 'Курс';

  @override
  String get totalDistance => 'Общее расстояние';

  @override
  String get distanceTravelled => 'Пройденное расстояние';

  @override
  String get distanceRemaining => 'Оставшееся расстояние';

  @override
  String get timeToDestination => 'Время до прибытия ';

  @override
  String get etaLocal => 'Ожидаемое время прибытия';

  @override
  String get etaZulu => 'ETA Zulu';

  @override
  String get country => 'Страна';

  @override
  String get name => 'Имя';

  @override
  String get callsign => 'Позывной';

  @override
  String get airlineDetails => 'Данные авиакомпании';

  @override
  String get flightDetails => 'Данные о рейсе';

  @override
  String captain(Object name) {
    return 'Капитан $name';
  }

  @override
  String get aircraft => 'Воздушное судно';

  @override
  String get company => 'Компания';

  @override
  String get arrived => 'Прибыл';

  @override
  String get enRoute => 'В пути';

  @override
  String get approaching => 'Прибывает ';

  @override
  String get circuits => 'Круги';

  @override
  String get virtualAirline => 'Виртуальная авиакомпания';

  @override
  String get flag => 'Флаг';

  @override
  String get region => 'Регион';

  @override
  String get clearance => 'Разрешение';

  @override
  String get boarding => 'Посадка';

  @override
  String get departing => 'Вылет';

  @override
  String get arrivingShortly => 'Скоро прибудет';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get notAvailable => 'Недоступно';

  @override
  String get noOFP => 'План полета не указан';

  @override
  String get waitingOFP => 'Ожидание плана полета';

  @override
  String get unknownAircraft => 'Неизвестное воздушное судно';

  @override
  String get noFlightDetails =>
      'Невозможно загрузить данные рейса. Попробуйте позже.';

  @override
  String get flightDisconnected => 'Рейс отключился от сети.';

  @override
  String get errorFlightLoad =>
      'Ошибка при получении данных рейса. Попробуйте позже.';

  @override
  String get airportSearch => 'Поиск аэропорта';

  @override
  String get vatsimEvents => 'События Vatsim';

  @override
  String get settings => 'Настройки';

  @override
  String get atcNetwork => 'Сеть ATC';

  @override
  String get language => 'Язык';

  @override
  String get aboutApp =>
      'Sim Flights Tracker – это приложение для отслеживания полётов в сети Vatsim и Ivao.';

  @override
  String get appDisclaimer =>
      'Все торговые марки и логотипы принадлежат их владельцам.';

  @override
  String get loaderText => 'Получение данных';

  @override
  String get searchATC => 'Поиск по коду области или ICAO аэропорта';

  @override
  String get noControllers => 'Диспетчеры не найдены.';

  @override
  String get searchAirports => 'Поиск по названию или ICAO аэропорта';

  @override
  String get airportsInfo => 'Найдите информацию об аэропортах по всему миру';

  @override
  String get oops => 'Упс! Что-то пошло не так.';

  @override
  String get noFlightsQuery => 'Рейсы не найдены';

  @override
  String get searchWithFlightNumber => 'Поиск по номеру рейса';

  @override
  String get onlineControllers => 'Диспетчеры в сети';

  @override
  String get identification => 'Идентификация';

  @override
  String get surface => 'Покрытие';

  @override
  String get hasLights => 'Есть освещение?';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get viewDetails => 'Просмотр деталей';

  @override
  String get elevation => 'Высота';

  @override
  String get lostInternetConnection => 'Потеряно соединение с сетью ';

  @override
  String get hasNotStarted => 'Не началось';

  @override
  String get startingNow => 'Начинается сейчас';

  @override
  String get inProgress => 'В процессе';

  @override
  String get endingNow => 'Заканчивается сейчас';

  @override
  String get hasEnded => 'Завершено';

  @override
  String get tapToExit => 'Нажмите назад для выхода';

  @override
  String get variable => 'Переменная';

  @override
  String get noMetar => 'Нет информации о погоде';

  @override
  String get windCalm => 'Штиль';

  @override
  String get goBack => 'Назад';

  @override
  String get noEvents => 'Событий не найдено';

  @override
  String get noEventsPlanned => 'Нет запланированных событий';

  @override
  String get dateType => 'Дата/время';

  @override
  String get hourLetter => 'ч';

  @override
  String get minuteShort => 'мин';

  @override
  String get local => 'Местное';

  @override
  String timeSelection(Object type) {
    return 'Время и даты указаны в $type времени';
  }

  @override
  String get delivery => 'Доставка';

  @override
  String get ground => 'Перрон';

  @override
  String get tower => 'Башня';

  @override
  String get approach => 'Подход';

  @override
  String get center => 'Центр';

  @override
  String get atcFull => 'Диспетчер воздушного движения';

  @override
  String get flyingNoOfp => 'Полет без плана';

  @override
  String get shareEvent => 'Поделиться событием';

  @override
  String get partakingAirports => 'Участвующие аэропорты';

  @override
  String get endTime => 'Время окончания';

  @override
  String get startTime => 'Время начала';

  @override
  String get organizer => 'Организатор';

  @override
  String get eventDetails => 'Детали события';

  @override
  String get eventReminderRemoved => 'Напоминание о событии удалено.';

  @override
  String get eventReminderSet => 'Напоминание о событии установлено.';

  @override
  String get eventAdd => 'Добавить напоминание';

  @override
  String get eventRemove => 'Удалить напоминание';

  @override
  String get minutes => 'минут';

  @override
  String get hours => 'часы';

  @override
  String get watchAd => 'Смотреть рекламу';

  @override
  String get flightsLog => 'Профиль VATSIM';

  @override
  String get flightInProgress => 'Рейс выполняется';

  @override
  String get noFlightHistory =>
      'Нет истории полётов. Проверьте ваш Vatsim ID в настройках приложения.';

  @override
  String get helipad => 'Вертолетная площадка';

  @override
  String get runways => 'Взлетно-посадочные полосы';

  @override
  String get vatsimId => 'Vatsim ID';

  @override
  String get about => 'О приложении ';

  @override
  String get latestHundredFlights => 'Профиль VATSIM и рейсы';

  @override
  String get searchAirportInformation =>
      'Поиск информации об аэропорте и метаданных';

  @override
  String get vatsimEventsDescription =>
      'Текущие и предстоящие события на Vatsim';

  @override
  String get settingsDescription => 'Предпочтения и взносы';

  @override
  String get aboutAppDescription => 'Информация о приложении и разработчике';

  @override
  String get totalFlightCount => 'Всего рейсов';

  @override
  String get viewMore => 'Более';

  @override
  String get events => 'События';

  @override
  String get supportApp =>
      'Love using the app? Help us keep improving by making a contribution below! Your support goes a long way. And while you\'re here, we\'d appreciate it if you could take a moment to rate us on Google Play or the App Store. Thank you!';

  @override
  String get donatePaypal => 'Купи мне кофе';

  @override
  String get pilotHours => 'Часы пилота';

  @override
  String get atcHours => 'Часы диспетчера';

  @override
  String get supHours => 'Часы супервизора';

  @override
  String get generalSettings => 'Общие настройки';

  @override
  String get vatsimSettings => 'Настройки VATSIM';

  @override
  String get supportTheApp => 'Приложение поддержки';

  @override
  String get cruiseAltitude => 'Высота круиза';

  @override
  String get cruiseSpeed => 'Крейсерская скорость';

  @override
  String get navbarStyle => 'Стиль навигационной...';

  @override
  String get loginWithVatsim => 'Войдите с помощью своей учетной записи VATSIM';

  @override
  String get loginWithVatsimLabel =>
      'Просмотрите данные профиля, историю полётов и многое другое';

  @override
  String get authWithVatsim => 'Войти через VATSIM';

  @override
  String get logout => 'Выйти';

  @override
  String get configLoadFail =>
      'Не удалось загрузить конфигурацию приложения. Пожалуйста, перезапустите приложение.';

  @override
  String get screenNotFound => 'Экран, который вы ищете, не существует.';
}
