# Подготовка рабочей среды для проведения лабораторных работ по курсу «Базы данных»

## Введение

Данное руководство описывает процесс установки и настройки рабочей среды
для изучения курса «Базы данных». В качестве ОС используется
`Debian GNU/Linux 7 (Wheezy)`, СУБД — `MySQL`, работа в которой
проводится как с помощью `MySQL monitor`, так и из различных программ
на разных языках программирования.

## Установка ОС (`Debian/GNU Linux`)

Текущая версия `Debian` — `Wheezy (7.x)`.

Для установки достаточно скачать образ `netinst CD` с любого из зеркал
проекта `Debian`, например, расположенного на Яндексе. Для этого
требуется выбрать нужную архитектуру. Для современных ПК это [amd64][],
для 32-разрядных Intel-совместимых процессоров — [i386][]. Последний
вариант годится для установки и на современный ПК (при установке в
`VirtualBox` рекомендуется воспользоваться именно данным вариантом ввиду
более экономного расходования оперативной памяти).

[i386]:  http://mirror.yandex.ru/debian-cd/7.8.0/i386/iso-cd/debian-7.8.0-i386-netinst.iso "i386 netinst CD"
[amd64]: http://mirror.yandex.ru/debian-cd/7.8.0/amd64/iso-cd/debian-7.8.0-amd64-netinst.iso "amd64 netinst CD"

При установке `Debian GNU/Linux` следует руководствоваться официальной
[документацией][instman] по установке (предоставляется для разных
архитектур и в разных форматах: `HTML`, `PDF`, простой текст).

[instman]: https://www.debian.org/releases/stable/installmanual "Руководство по установке Debian GNU/Linux"

При настройке установленной ОС рекомендуется пользоваться официальным
[руководством][dahb] администратора.

[dahb]: http://debian-handbook.info/ "The Debian Administrator's Handbook"

Далее установка `Debian` рассматривается на примере инсталляции версии
для архитектуры i386 в `VirtualBox`.

При установке на реальное железо следует внимательно заранее прочитать
указанное выше руководство по установке (в частности, обратив внимание
на пункты 2.2 и 6.4, иначе можно оказаться без Сети во время установки
ОС). Также рекомендуется при наличии на ПК какой-либо установленной ОС
(вообще при необходимости сохранения имеющихся данных на жёстком диске,
на который предполагается ставить `Debian`) подготовить разделы диска
для установки с помощью [GParted Live][gplive].

[gplive]: http://gparted.org/livecd.php "GParted Live"

### Создание виртуальной машины

* Установить (в том числе, `Extension Pack`) и настроить
  [Oracle Virtualbox][VBox].
* С помощью Мастера создать виртуальную машину для `Debian GNU/Linux`,
  выделив ей виртуальный жёсткий диск объёмом 25 GB и 2 GB оперативной
  памяти (можно больше, если позволяют ресурсы компьютера; чем больше
  оперативной памяти выделить — тем лучше; однако не следует
  оставлять для хост-системы слишком мало — для современных
  операционных систем 2 GB являются разумным минимумом).
* Настроить её следующим образом:
  * Общие.
    * Основные:

      ![Основные][genbas]
    * Дополнительно:

      ![Дополнительно][genadv]
  * Система.
    * Материнская плата:

      ![Материнская плата][sysmob]
    * Процессор:

      ![Процессор][syscpu]
    * Ускорение:

      ![Ускорение][sysacc]
  * Дисплей.
    * Видео:

      ![Видео][disvid]
  * Носители.
    * CD (пример приведён для использования в процессе установки образа
      CD). Если загрузка будет производиться с CD, записанного на
      оптический носитель, то необходимо указать здесь физический
      привод.

      ![Носители][storcd]
    * HDD:

      ![HDD][storhdd]
  * Остальные настройки можно не трогать, оставить их по умолчанию.

[VBox]: https://virtualbox.org/wiki/Downloads "Download VirtualBox"
[genbas]: VirtualBox/settings-01.png "Общие | Основные"
[genadv]: VirtualBox/settings-02.png "Общие | Дополнительно"
[sysmob]: VirtualBox/settings-03.png "Система | Материнская плата"
[syscpu]: VirtualBox/settings-04.png "Система | Процессор"
[sysacc]: VirtualBox/settings-05.png "Система | Ускорение"
[disvid]: VirtualBox/settings-06.png "Дисплей | Видео"
[storcd]: VirtualBox/settings-07.png "Носители | CD"
[storhdd]: VirtualBox/settings-16.png "Носители | HDD"

### Установка базовой системы

Для установки требуется наличие соединения с Интернетом в хостовой
системе.

В `VirtualBox` выбираем виртуальную машину с `Debian` и нажимаем
«Запустить». Появляется «Debian GNU/Linux installer boot menu», выбираем
пункт «Advanced options».

![Advanced options][advopt]

Выбираем «Alternative desktop environments».

![Alternative desktop environments][altde]

Выбираем «Xfce«.

![Xfce][xfce]

Далее «Advanced options».

![Advanced options][xfceadvopt]

Выбираем «Graphical expert install», после чего попадаем в главное меню
инсталлятора. На каждом этапе установки необходимо будет выбирать
некоторые значения (часто значения по умолчанию вполне подходят) и
нажимать кнопку «Continue» («Продолжить») или нажимать на клавишу
`Enter`. В некоторых пунктах меню потребуется выполнить более сложные
действия (ввод данных и т. п.).

![Graphical expert install][guiexp]

Первым пунктом меню является запрос на выбор языка, на котором
установщик будет выводить элементы меню.

![Выбор языка][chlang]

Выбираем на следующем экране «Russian - Русский».

![Russian - Русский][chruss]

Выбираем страну: «Российская Федерация».

![Российская Федерация][chcountry]

В качестве региональных настроек (локалей) отмечаем пункт «Российская
Федерация — ru_RU.UTF-8».

![Российская
Федерация — ru_RU.UTF-8][chlocale]

В качестве дополнительных локалей помечаем «en_US.UTF-8» и «en_US».

![Дополнительные локали][addloc]

Локалью по умолчанию ставим «ru_RU.UTF-8».

![Локаль по умолчанию][defloc]

Настройка синтезатора речи: выбираем продолжить.

![Настройка синтезатора речи][synconf]

Следующий пункт — настройка клавиатуры.

![Настройка клавиатуры][keybconf]

Выбираем «Русская».

![Русская клавиатура][keybru]

Далее предлагается выбрать способ переключения между русской и латинской
раскладками; отмечаем желаемый вариант (например, правый `Control`).

![Right Ctrl][rctrl]

Следующий пункт — поиск и монтирование CD-ROM.

![CD-ROM][cdfind]

Далее установщик определяет, какие загружаемые модули необходимы для
работы с оборудованием. Соглашаемся с выбором.

![Загружаемые модули][addmod]

Выводится сообщение, что найден инсталляционный CD-ROM. Нажимаем
«Продолжить».

![Найден инсталляционный CD-ROM][cdfound]

Следующий пункт — загрузка компонентов программы установки с
компакт-диска.

![Загрузка компонентов программы установки][cddown]

Выводится список компонентов программы установки, доступных для
загрузки. Можно оставить всё по умолчанию, не выбрав ничего.

![Список компонентов программы установки][notreq]

Далее — определение сетевой карты.

![Определение сетевой карты][netcard]

После этого предлагается настроить сеть.

![Настроить сеть][netconf]

Выводится запрос на автоматическую настройку сети. Соглашаемся.

![Автоматическая настройка сети][autonet]

Можно ввести максимальный срок ожидания автоматической настройки.

![Максимальный срок ожидания][automax]

Предлагается ввести имя компьютера (можно оставить по умолчанию или
выбрать какое-то другое).

![Имя компьютера][hostname]

На следующем экране следует ввести имя домена (если дома есть локальная
сеть, то можно ввести то имя, которое используется на других машинах).

![Имя домена][domname]

Следующий пункт — настройка учётных записей пользователей и паролей.

![Настройка учётных записей пользователей][accconf]

На следующем экране поддержки теневых паролей и учётной записи `root`
следует оставить значения по умолчанию.

![Теневые пароли][shroot]

Далее предлагается ввести пароль `root` (дважды). Не следует использовать
пароли вида `123456` или слово, которое может быть найдено по словарю.
Лучший вариант — использовать пароль, полученный с помощью генератора
псевдослучайных паролей. Пароль нужно запомнить, иначе не удастся
воспользоваться установленной ОС.

![Пароль root][rootpass]

На запрос о создании учётной записи обычного пользователя следует
ответить утвердительно.

![Учётная запись обычного пользователя][useracc]

На следующем экране следует ввести полное имя пользователя.

![Полное имя пользователя][username]

Далее ввести имя учётной записи.

![Имя учётной записи][accname]

На следующем экране ввести дважды пароль пользователя. Те же
рекомендации по выбору пароля, что и для пользователя `root`. Не стоит
выбирать одинаковый пароль для `root` и обычного пользователя.

![Пароль пользователя][userpass]

Следующий пункт меню — настройка времени.

![Настройка времени][timeconf]

Предлагается настроить часы, используя NTP. Можно согласиться.

![Настроить часы, используя NTP][ntptime]

Адрес NTP сервера можно оставить тот, что предлагается инсталлятором.

![Адрес NTP сервера][ntpaddr]

На следующем экране предлагается выбрать часовой пояс. К сожалению,
выбор там небольшой. Можно выбрать пункт «Москва» (в дальнейшем при
настройке системы можно будет внести изменения в настройку часового
пояса).

![Часовой пояс][timezone]

Следующий пункт — определение дисков.

![Определение дисков][diskdet]

Далее — разметка дисков.

![Разметка дисков][diskconf]

Выбираем «Вручную».

![Вручную][mandisk]

Выбор диска: в настройках виртуальной машины был создан единственный
диск, его и выбираем.

![Выбор диска][chdisk]

Создаём пустую таблицу разделов.

![Таблица разделов][diskpart]

Выбираем тип таблицы разделов: можно выбрать `msdos` или `gpt`.

![Тип таблицы разделов][tabltype]

Выбираем свободное пространство для создания раздела.

![Выбираем свободное пространство][chfreeswap]

Следующий экран — «Создать новый раздел».

![Создать новый раздел][newswap]

Выбираем размер раздела.

![Размер раздела][swapsize]

Далее выбираем его тип.

![Тип раздела][swaptype]

На следующем экране — его местоположение.

![Местоположение раздела][swapplace]

Настраиваем раздел, выбрав «Использовать как».

![Использовать как][chswap]

Выбираем «Раздел подкачки».

![Раздел подкачки][swappart]

Завершаем настройку раздела подкачки.

![Завершаем настройку раздела подкачки][swapend]

Выбираем свободное место для создания корневого раздела.

![Выбираем свободное место][chfreeroot]

Создаём новый раздел.

![Создаём новый раздел][newroot]

Выбираем размер раздела.

![Выбираем размер раздела][rootsize]

Его тип.

![Тип раздела][roottype]

Местоположение.

![Местоположение раздела][rootplace]

В настройках раздела можно оставить всё по умолчанию, выбираем
«Настройка раздела закончена».

![Настройка раздела закончена][rootend]

Вновь выбираем свободное место для создания раздела.

![Выбираем свободное место][chfreehome]

Создаём новый раздел.

![Создаём новый раздел][newhome]

В меню выбора размера раздела оставляем значение, указанное
инсталлятором (раздел будет создан на оставшемся свободном пространстве
диска).

![Размер раздела][homesize]

Выбираем тип раздела.

![Выбираем тип раздела][hometype]

Выбираем пункт «Зарезервированные блоки».

![Зарезервированные блоки][homeres]

Процент блоков файловой системы, зарезервированных для
суперпользователя, устанавливаем в 0%, поскольку в домашних каталогах
резервирование блоков для суперпользователя не нужно.

![Зарезервированные блоки 0%][homeresz]

В следующем меню выбираем «Настройка раздела закончена».

![Настройка раздела закончена][homeend]

Завершение разметки, запись изменений на диск.

![Завершение разметки][endpart]

Получаем запрос на запись изменений на диск, отвечаем утвердительно.

![Запись изменений на диск][writeclaim]

Следующий пункт — «Установка базовой системы».

![Установка базовой системы][baseinst]

После его выбора начинается процесс установки.

![Процесс установки][basepbar]

Далее следует запрос на выбор ядра для установки. Отмечаем указанный
пункт.

![Выбор ядра][chkern]

На запрос о выборе драйверов для включения в `initrd` выбираем «общий».

![initrd][initrd]

На следующем экране видим процесс установки базовой системы.

![Процесс установки базовой системы][baseproc]

Следующий пункт меню — «Настройка менеджера пакетов».

![Настройка менеджера пакетов][aptconf]

Отвечаем «Да» на запрос на использование архива пакетов из Сети.

![Использование архива пакетов из Сети][archclaim]

Выбираем протокол для загрузки файлов.

![Выбираем протокол][chprot]

Отмечаем «Российская Федерация» на запрос выбора страны зеркала архивов.

![Российская Федерация][charcount]

Выбираем зеркало архивов.

![Выбираем зеркало архивов][chmirror]

Оставляем пустым поле в настройках прокси, если доступ к Сети
осуществляется без использования прокси.

![Настройка прокси][proxyconf]

Отвечаем утвердительно на запрос об использовании несвободного ПО.

![Несвободное ПО][nfreeclaim]

На следующем экране идёт процесс настройки менеджера пакетов.

![Настройка менеджера пакетов][aptpbar]

Выбираем активируемые сервисы обновлений.

![Активируемые сервисы обновлений][repoch]

Следующий пункт меню — «Выбор и установка программного обеспечения».

![Выбор и установка программного обеспечения][chsoft]

Инсталлятор может предложить некоторые пакеты для поддержки
оборудования. `VirtualBox Guest Additions` поставим позднее, убираем
пометку.

![VirtualBox Guest Additions][guestadd]

Получаем запрос на участие в опросе популярности пакетов, выбираем
ответ.

![Опрос популярности пакетов][pcontest]

Запрос на кэширование страниц руководства, отвечаем «Нет» (по
умолчанию).

![Кэширование страниц руководства][setuidman]

Выбор программного обеспечения. Можно отметить пункты «Debian desktop
environment» и «Стандартные системные утилиты» или выбрать только
«Стандартные системные утилиты». Дальнейшее описание предполагает именно
последний вариант (всё остальное необходимое можно поставить позднее).

![Выбор программного обеспечения][chstand]

Следующий экран показывает процесс установки программного обеспечения.

![Процесс установки программного обеспечения][softpbar]

Установка системного загрузчика `GRUB` на жёсткий диск.

![Установка системного загрузчика][grub]

Получаем запрос на установку `GRUB` в `MBR`, отвечаем «Да».

![MBR][grubmbr]

Следующий пункт — «Завершение установки».

![Завершение установки][endinst]

На запрос о выборе показа времени в UTC отвечаем «Нет».

![Показ времени в UTC][utcclaim]

Установка завершена.

![Установка завершена][instdone]

Если установка производилось с образа CD, то установщик сам извлечёт
этот образ из виртуального привода; если же с CD, записанного на
матрицу, то нужно извлечь CD из привода. В обоих случаях далее нажать
«Продолжить».

[advopt]: install/01.png "Advanced options"
[altde]: install/02.png "Alternative desktop environments"
[xfce]: install/03.png "Xfce"
[xfceadvopt]: install/04.png "Advanced options"
[guiexp]: install/05.png "Graphical expert install"
[chlang]: install/07.png "Choose language"
[chruss]: install/08.png "Russian — Русский"
[chcountry]: install/09.png "Российская Федерация"
[chlocale]: install/10.png "Российская Федерация — ru_RU.UTF-8"
[addloc]: install/11.png "en_US.UTF-8 & en_US"
[defloc]: install/12.png "ru_RU.UTF-8"
[synconf]: install/13.png "Настройка синтезатора речи"
[keybconf]: install/14.png "Настройка клавиатуры"
[keybru]: install/15.png "Русская"
[rctrl]: install/16.png "правый Control"
[cdfind]: install/17.png "Поиск и монтирование CD-ROM"
[addmod]: install/18.png "usb-storage (USB stirage)"
[cdfound]: install/19.png "Обнаружен CD-ROM"
[cddown]: install/20.png "Загрузка компонентов программы установки с компакт-диска"
[notreq]: install/21.png "Компоненты программы установки, доступные для загрузки"
[netcard]: install/22.png "Определение сетевой карты"
[netconf]: install/23.png "Настройка сети"
[autonet]: install/24.png "Запрос на автоматическую настройку"
[automax]: install/25.png "Максимальный срок ожидания автоматической настройки"
[hostname]: install/26.png "Имя компьютера"
[domname]: install/27.png "Имя домена"
[accconf]: install/28.png "Настройка учётных записей пользователей и паролей"
[shroot]: install/29.png "Настройка теневых паролей и пользователя root"
[rootpass]: install/30.png "Пароль root"
[useracc]: install/31.png "Создание учётной записи обычного пользователя"
[username]: install/32.png "Ввод полного имени пользователя"
[accname]: install/33.png "Имя учётной записи"
[userpass]: install/34.png "Ввод пароля пользователя"
[timeconf]: install/35.png "Настройка времени"
[ntptime]: install/36.png "Настройка часов по NTP"
[ntpaddr]: install/37.png "Адрес NTP сервера"
[timezone]: install/38.png "Выбор часового пояса"
[diskdet]: install/39.png "Определение дисков"
[diskconf]: install/40.png "Разметка дисков"
[mandisk]: install/41.png "Вручную"
[chdisk]: install/42.png "Выбор диска"
[diskpart]: install/43.png "Создание пустой таблицы разделов"
[tabltype]: install/44.png "Выбор типа таблицы разделов"
[chfreeswap]: install/45.png "Выбор свободного пространства для создания раздела"
[newswap]: install/46.png "Создание нового раздела"
[swapsize]: install/47.png "Выбор размера раздела"
[swaptype]: install/48.png "Выбор типа раздела"
[swapplace]: install/49.png "Выбор местоположения раздела"
[chswap]: install/50.png "Настройки раздела | Выбор файловой системы"
[swappart]: install/51.png "Раздел подкачки"
[swapend]: install/52.png "Завершение настройки раздела подкачки"
[chfreeroot]: install/53.png "Выбор свободного пространства для создания раздела"
[newroot]: install/54.png "Создание нового раздела"
[rootsize]: install/55.png "Выбор размера раздела"
[roottype]: install/56.png "Выбор типа раздела"
[rootplace]: install/57.png "Выбор местоположения раздела"
[rootend]: install/58.png "Завершение настройки корневого раздела"
[chfreehome]: install/59.png "Выбор свободного пространства для создания раздела"
[newhome]: install/60.png "Создание нового раздела"
[homesize]: install/61.png "Выбор размера раздела"
[hometype]: install/62.png "Выбор типа раздела"
[homeres]: install/63.png "Зарезервированные блоки"
[homeresz]: install/64.png "Процент блоков файловой системы, зарезервированных для суперпользователя"
[homeend]: install/65.png "Завершение настройки домашнего раздела"
[endpart]: install/66.png "Завершение разметки, запись изменений на диск"
[writeclaim]: install/67.png "Запрос на запись изменений на диск"
[baseinst]: install/68.png "Установка базовой системы"
[basepbar]: install/69.png "Процесс установки базовой системы"
[chkern]: install/70.png "Выбор ядра для установки"
[initrd]: install/71.png "Выбор драйверов для включения в initrd"
[baseproc]: install/72.png "Установка базовой системы"
[aptconf]: install/73.png "Настройка менеджера пакетов"
[archclaim]: install/74.png "Запрос на использование архива пакетов из Сети"
[chprot]: install/75.png "Выбор протокола для загрузки файлов"
[charcount]: install/76.png "Выбор страны зеркала архивов"
[chmirror]: install/77.png "Выбор зеркала архивов"
[proxyconf]: install/78.png "Настройка прокси"
[nfreeclaim]: install/79.png "Запрос на использование несвободного ПО"
[aptpbar]: install/80.png "Процесс настройки менеджера пакетов"
[repoch]: install/81.png "Выбор активируемых сервисов"
[chsoft]: install/82.png "Выбор и установка программного обеспечения"
[guestadd]: install/83.png "Предлагаемые пакеты для установки"
[pcontest]: install/84.png "Запрос на участие в опросе популярности пакетов"
[setuidman]: install/85.png "Запрос на кэширование страниц руководства"
[chstand]: install/86.png "Выбор программного обеспечения"
[softpbar]: install/87.png "Установка программного обеспечения"
[grub]: install/88.png "Установка системного загрузчика GRUB на жёсткий диск"
[grubmbr]: install/89.png "Запрос на установку GRUB в MBR"
[endinst]: install/90.png "Завершение установки"
[utcclaim]: install/91.png "Запрос на выбор времени в UTC"
[instdone]: install/92.png "Установка завершена"

Виртуальная машина после этого будет перезагружена.

![Меню GRUB][grubmenu]

Можно авторизоваться в системе, введя последовательно логин `root`, а
затем пароль (после запроса).

![Можно авторизоваться в системе][conslogin]

Выключить виртуальную машину, выполнив команду `halt`.

[grubmenu]: postinstall/01.png "Меню загрузчика GRUB"

[conslogin]: postinstall/02.png "Консольный вход в систему"

### Изменение настроек виртуальной машины

После установки базовой системы следует изменить некоторые настройки
виртуальной машины.

* Оставить загрузку только с жёсткого диска:

  ![Загрузка][sysmobo]

* Заменить в настройках Носители инсталляционный CD (или его образ) на
  образ CD VBoxGuestAdditions:

  ![Носители][storage]

[sysmobo]: VirtualBox/settings-13.png "Система | Материнская плата"
[storage]: VirtualBox/settings-14.png "Носители"

## Конфигурирование системы и ПО

### Начальная настройка системы

Для конфигурирования требуется наличие соединения с Интернетом в
хостовой системе.

Загрузить виртуальную машину с `Debian`.

Авторизоваться в системе, введя последовательно логин `root`, а затем
пароль (после запроса).

После авторизации выполнить следующие команды:

```text
# aptitude install xfce4 xfce4-terminal lightdm gawk git -y
# service lightdm start
```

Появляется окно `LightDM`:

![LightDM][lightdm]

Следует ввести имя вашей учётной записи (которая была создана при
установке):

![Login][dmlogin]

На следующем экране запрашивается пароль учётной записи. Следует его
ввести.

![Пароль][dmpass]

Загружается XFCE:

![XFCE][xfcein]

Для завершения сеанса пользователя, перезагрузки системы или её
выключения после нажатия соответствующей пиктограммы на панели (или
через меню — пункт «Выйти») следует выбирать соответствующее действие.

![XFCE out][xfceout]

Например, для выключения виртуальной машины следует выбрать пункт
«Выключить».

![XFCE off][xfceoff]

Запустить терминал.

Выполнить команды:

```text
$ git clone https://github.com/AVKorotkov/setupenv
$ cp setupenv/preuser.sh .
$ ./preuser.sh
```

(во второй команде последний символ — точка).

Это необходимо сделать для предварительной настройки пользовательского
окружения — данный скрипт:

* устанавливает нужные права и создаёт нужные каталоги,
* обновляет git-репозиторий `setupenv` до последней актуальной версии,
* копирует некоторые файлы в места их назначения,
* скачивает и устанавливает IDE `Eclipse`,
* скачивает `RStudio`.

Далее следует сделать предварительные настройки системы. Это необходимо
делать от имени суперпользователя (`root`). Для выполнения таких
действий нужно получить права суперпользователя. Это можно сделать с
помощью команды `su`:

```text
$ su -
```

(имя команды — `su`, затем пробел, потом символ дефиса). На запрос
пароля ввести пароль `root`, заданный во время установки системы. Для
этого лучше всего открыть дополнительную вкладку терминала (в случае
использования `XFCE Terminal` это можно сделать клавиатурной комбинацией
`<Shift>+<Ctrl>+<T>`; переключаться между вкладками можно комбинациями
`<Ctrl>+<PageUp>` и `<Ctrl>+<PageDown>`).

После получения прав `root` выполнить команды:

```text
# mv /tmp/sysconf.sh .
# chown root:root sysconf.sh
# ./sysconf.sh
```

(в первой команде последний символ — точка). Данный скрипт:

* копирует нужные файлов в места их назначения,
* выставляет на них необходимые права,
* настраивает репозитории с ПО,
* обновляет список пакетов,
* делает обновление системы,
* устанавливает последнее ядро и пакеты заголовков,
* устанавливает ПО,
* устанавливает дополнительного ПО (по желанию),
* добавляет пользователя в нужные группы,
* устанавливает `VirtualBox Guest Additions`.

После выполнения данного скрипта лучше перезагрузить виртуальную машину,
чтобы задействовать установленные `VirtualBox Guest Additions`.

Следующий скрипт — `userconf.sh` — должен быть запущен на выполнение
от пользователя:

```text
$ ./userconf.sh
```

Он выполняет следующие действия:

* настройку `MySQL` в `~/.my.cnf`:
  * установку логинов и паролей,
  * установку прав на действия с базами данных.
* сборку пакета `Oracle JDK`;
* настройку `~/.bashrc` (пользовательские настройки работы в `bash`).

Наконец, последним выполняется от `root` скрипт `postconf.sh`

```text
# ./postconf.sh
```

Этот скрипт:

* настраивает время,
* устанавливает и настраивает `Java`,
* настраивает `MySQL`.

На этом первоначальную настройку системы можно считать законченной.

[lightdm]: config/config-01.png "Lightdm"
[dmlogin]: config/config-02.png "Lightdm учётная запись"
[dmpass]: config/config-03.png "Lightdm пароль"
[xfcein]: config/config-04.png "XFCE загружен"
[xfceout]: config/config-05.png "XFCE выход"
[xfceoff]: config/config-06.png "XFCE выключение"

### Настройка `MySQL Workbench` и `Eclipse`

Запустить на выполнение `MySQL Workbench`. Появится начальное окно
программы:

![MySQL Workbench][mwmain]

Следует выбрать в меню `Edit -> Preferences...`:

![Edit -> Preferences][mwpref]

Далее нужно перейти на вкладку `SQL Editor`:

![SQL Editor][mwprefed]

и вписать в поле `Default SQL_MODE` значение `TRADITIONAL`:

![Default SQL_MODE][mwprefmode]

Нажать `OK`. Остальные настройки можно оставить по умолчанию.

В главном окне программы выбрать в меню `Database -> Manage
Connections...`:

![Database -> Manage Connections][mwconn]

В появившемся диалоговом окне нажать кнопку `New`:

![New][mwnewconn]

В поле `Connection Name` вписать `localhost`, в `Username` — `dbuser`:

![Connection Name][mwconnname]

После этого нажать кнопку `Test Connection`. Если всё было сделано
правильно, то должно появиться сообщение, что тест пройден успешно:

![Test Connection][mwconntest]

Нажать кнопки `OK`, затем `Close` и убедиться, что созданное соединение
присутствует в списке:

![Connection][mwconnready]

[mwmain]: workbench/main-001.png "Начальное окно"
[mwpref]: workbench/pref-001.png "Настройки"
[mwprefed]: workbench/pref-002.png "Настройки SQL Editor"
[mwprefmode]: workbench/pref-003.png "Настройки SQL_MODE"
[mwconn]: workbench/conn-001.png "Соединения"
[mwnewconn]: workbench/conn-002.png "Новое соединение"
[mwconnname]: workbench/conn-003.png "Имя оединения и пользователя"
[mwconntest]: workbench/conn-004.png "Тестирование соединения"
[mwconnready]: workbench/conn-005.png "Готово"

Запустить на выполнение `Eclipse`, вызвав из меню `XFCE`. В `Eclipse`
выбрать в меню `Help -> Check for Updates`.

![Eclipse Help -> Check for Updates][eclchupd]

`Eclipse` проверяет наличие обновлений установленных компонентов,
скачивает их и устанавливает.

![Наличие обновлений][eclupd]

Далее необходимо установить компонент `ERMaster`. Для этого выбрать в
меню `Help -> Install New Software`.

![Help -> Install New Software][eclnew]

Нажать кнопку `Add...`

![Add][ecladdsel]

Появится окно для добавления нового репозитория.

![Новый репозиторий][ecladdrepo]

В поле `Name` указать `ERMaster`, в поле `Location` — его
[адрес][ermaster], нажать `OK`.

[ermaster]: http://ermaster.sourceforge.net/update-site/ "Репозиторий ERMaster"

![ERMaster][eclrepoloc]

`Eclipse` проверяет наличие компонентов по указанному адресу.

![Наличие компонентов][eclavail]

После того как информация об имеющихся компонентах будет загружена,
следует нажать кнопку `Select All`, потом `Next`.

![Select All][eclselsoft]

Появляется следующее окно с детальной информацией об устанавливаемых
компонентах. Нажать кнопку `Next`.

![Детальная информация][eclinstdet]

Принять условия лицензии, выбрав значение переключателя
`I accept the terms of the license agreement`. Нажать кнопку `Finish`.

![License agreement][ecllic]

Появляется окно с информацией об установке компонент.

![Установка компонент][eclinst]

В окне `Security Warning` появляется информация об установке
неподписанного содержимого. Подтвердить согласие на установку, нажав
кнопку `OK`.

![Security Warning][eclwarn]

После установки ПО появляется сообщение о том, что необходимо
перезапустить `Eclipse`, чтобы изменения вступили в силу. Нажать `Yes`.

![Перезапустить Eclipse][eclrest]

[eclchupd]: eclipse/01.png "Check for Updates"
[eclupd]: eclipse/02.png "Updates"
[eclnew]: eclipse/03.png "Install New Software"
[ecladdsel]: eclipse/04.png "Select Add"
[ecladdrepo]: eclipse/05.png "Add Repository"
[eclrepoloc]: eclipse/06.png "Name and Location of Repository"
[eclavail]: eclipse/07.png "Available Software"
[eclselsoft]: eclipse/08.png "Select Software"
[eclinstdet]: eclipse/09.png "Install Details"
[ecllic]: eclipse/10.png "Review Licences"
[eclinst]: eclipse/11.png "Installing Software"
[eclwarn]: eclipse/12.png "Security Warning"
[eclrest]: eclipse/13.png "Software Updates"

### Проверка работы `Apache` и `PHP`

Запустить браузер, например, `Iceweasel` (ребрендированный в `Debian` по
лицензионным соображениям `Firefox`) и открыть главную страницу сервера
`Apache`, вписав в строку адреса [localhost][localhost], после чего
нажать `Enter`.

[localhost]: http://localhost/ "Адрес локального хоста"

В окне браузера должна появиться начальная страница `Apache` (служит
только для проверки его работоспособности):

![начальная страница Apache][apache]

После этого нужно проверить работу модуля `PHP` сервера `Apache`. Для
этого в строке адреса браузера ввести [адрес][apachephp] скрипта
проверки:

![PHP][phpinfo]

[apachephp]: http://localhost/info.php "Проверка работы phpinfo()"

Результат должен быть примерно такой, как на данном снимке экрана.

[apache]: apache/01.png "Начальная страница Apache"
[phpinfo]: apache/02.png "Проверка работы модуля PHP с помощью phpinfo()"

## Заключение

На этом необходимые настройки программной среды для проведения
лабораторных работ по курсу «Базы данных» можно считать законченными.

Другие настройки программного обеспечения выполняются по желанию и
зависят от предпочтений выбора того или иного ПО при выполнении работ
(например, писать код программ можно в любом из имеющихся на выбор
редакторов или IDE, настраивая их в соответствии с собственными
предпочтениями).

Описание настроек системного характера (обеспечение безопасности,
обновление программных компонентов и т. д.) не входило в задачи данного
руководства. Для этого следует пользоваться официальной документацией
проекта `Debian`, ссылки на которую имеются в разделе «Введение».
