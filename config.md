## Конфигурирование системы и ПО ##

Загрузить виртуальную машину с `Debian`.

Авторизоваться в системе, введя последовательно логин `root`, а затем
пароль (после запроса).

После авторизации выполнить следующие команды:

	# aptitude install xfce4 xfce4-terminal lightdm gawk git
	# service lightdm start

Появляется окно `LightDM`:

![][lightdm]

Следует ввести имя вашей учётной записи (которая была создана при
установке):

![][dmlogin]

На следующем экране запрашивается пароль учётной записи. Следует его
ввести.

![][dmpass]

Загружается XFCE:

![][xfcein]

В диалоге завершения сеанса после нажатия соответствующей пиктограммы
следует выбрать выключение системы.

![][xfceout]

[lightdm]: config/config-01.png "Lightdm"
[dmlogin]: config/config-02.png "Lightdm учётная запись"
[dmpass]: config/config-03.png "Lightdm пароль"
[xfcein]: config/config-04.png "XFCE загружен"
[xfceout]: config/config-05.png "XFCE выход"

Дальнейшее в процессе написания...
