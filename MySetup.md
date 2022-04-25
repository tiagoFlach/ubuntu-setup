# SETUP


### Dell G5-5590
### Windows + Ubuntu

---

### Dell G5 15 5590

Intel® Core™ i7-9750H (2.6 GHz até 4.5 GHz, cache de 12MB, hexa-core, 9ª geração)  
Placa de vídeo dedicada NVIDIA® GeForce® RTX™ 2060 com 6GB de GDDR6  
Memória de 16GB (2x8GB), DDR4, 2666MHz  
SSD de 256 GB NVMe PCIe M.2  
HD de 1TB (5400 RPM) SATA 2,5"  
Tela LED Full HD IPS de 15,6" (1920 x 1080), 144hZ, 300 nits, antirreflexo, retroiluminado e borda fina  
Placa de rede Dell Wireless™ 802.11ac  
Bluetooth 4.1, banda dupla (2.4 GHz/5 GHz)  
Bateria de 4 células e 60Wh (integrada)  


[Página](https://www.dell.com/pt-br/shop/notebooks-dell/dell-g5-15/spd/g-series-15-5590-laptop/cg5590w7048brw)  
[Suporte](https://www.dell.com/support/home/br/pt/brdhs1/product-support/product/g-series-15-5590-laptop/overview)  
[Drivers Windows](https://www.dell.com/support/home/br/pt/brdhs1/product-support/product/g-series-15-5590-laptop/drivers)  

[Vídeo com especificações](https://www.youtube.com/watch?v=BfszKYC2Fus)


---

### Alienware Advanced Gaming Mouse – AW558

3 configurações dinâmicas de DPI  
Resolução de 200 a 5000 DPI  
Velocidade de 100 IPS  
Aceleração de 20 G  
Taxa de amostragem de 1000 Hz (1 ms)  
10 milhões de cliques Omron  
9 botões totalmente programáveis  


[Página](https://www.dell.com/pt-br/shop/accessories/apd/275-bbcs)  
[Drivers Windows](https://www.dell.com/support/home/br/pt/brdhs1/product-support/product/alienware-advanced-gaming-mouse-aw558/drivers)  


---

### Particionamento

- SSD
	- Windows - 120 GB
	- Ubuntu - 100 GB

| Partição		| Tamanho		| Sistema de Arquivos	| Montagem		| Rótulo			|
|--------------	|--------------	|----------------------	|--------------	|------------------	|
| sda1			| 512 MB		| fat32					| /boot/efi		| Boot				|
| sda2			| 9,8 GB		| NTFS					|				| Data Safe			|
| sda3			| 100 GB		| NTFS					|				| Windows			|
| sda4			| 8 GB			| linux-swap			|				| Swap				|
| sda5			| 60 GB			| ext4					| /				| Raiz Ubuntu		|

<br />

- HDD
	- Windows - 330 GB
	- Ubuntu - 600 GB

| Partição		| Tamanho		| Sistema de Arquivos	| Montagem		| Rótulo			|
|--------------	|--------------	|----------------------	|--------------	|------------------	|
| sdb1			| 600 GB		| NTFS					| /home			| (E:) Home Ubuntu	|
| sdb2			| 330 GB		| NTFS					|				| (D:)				|  

<br />

[Particionamento](https://plus.diolinux.com.br/t/como-fazer-dual-boot-tendo-um-hd-e-um-ssd/5088/3)  


---

### Softwares

- WINDOWS  
	- Adobe Reader
	- Adobe Lightroom
	- BitTorrent
	- Dell
		- Alienware Command Center
		- Centro de comandos de gráficos Intel
		- Centro de Controle Thunderbolt
		- Dell Digital Delivery
		- Dell Power Manager
		- Dell Update
		- Killer Control Center
		- McAfee LiveSafe
		- Nvidia Control Panel
		- SupportAssist
	- Discord
	- Driver Booster
	- Firefox
	- Google Chrome
	- Google Earth Pro
	- Gimp
	- LibreOffice
	- Microsoft Office
	- Netflix
	- OBS Studio
	- Popcorn Time
	- Skype
	- Simplenote
	- Spotify
	- Steam
	- Sublime Text
	- TuneIn Radio
	- VLC
	- WhatsApp

<br />

- UBUNTU
	- Atom
	- Discord
	- FileZilla
	- Firefox
	- Inkscape
	- Google Chrome
	- Google Earth Pro
	- Gimp
	- GitKraken
	- LibreOffice
	- MuseScore
	- News Flash
	- OBS Studio
	- Popcorn Time
	- Shortwave
	- Simplenote
	- Skype
	- Slack
	- Spotify
	- Stacer
	- Stellarium
	- Sublime Text
	- Synaptic
	- ~~TimeShift~~
	- Telegram
	- VLC
	- VirtualBox
	- Visual Studio
	- ~~WPS Office~~

---

### Ubuntu 20.04

#### Personalizações

- Cursor: [Vimix](https://www.gnome-look.org/p/1358330/)
- Fonte - Terminal: [Source Code Pro](https://fonts.google.com/specimen/Source+Code+Pro)  

#### Fontes
|                            	| Fonte original      	| Tamanho original 	| Fonte utilizada   	| Tamanho utilizado 	|
|----------------------------	|---------------------	|------------------	|-------------------	|-------------------	|
| Texto da interface         	| Ubuntu Regular      	| 11               	| Roboto Regular    	| 11                	|
| Texto do documento         	| Sans Regular        	| 11               	| Cantarell Regular 	| 11                	|
| Texto monoespaçado         	| Ubuntu Mono Regular 	| 13               	| Source Code Pro   	| 12                	|
| Título das janelas legadas 	| Ubuntu Bold         	| 11               	| Cantarell Bold    	| 11                	|

#### Extensões

- [Blyr](https://extensions.gnome.org/extension/1251/blyr/)
	- Apply Effect to: Activities Screen
	- Blur Intensity: 10
	- Activities Background Brightness: 0.75
	- Panel Background Brightness: 0.8
- [Coverflow Alt-Tab](https://extensions.gnome.org/extension/97/coverflow-alt-tab/)
	- Ocultar o painel durante o coverflow: On
	- Estilo do ícone do aplicativo: Sobreposição 
- [Custom Hot Corners - Extended](https://extensions.gnome.org/extension/4167/custom-hot-corners-extended/)
	- Monitor:
		- Top Left:
			- Show Activities Overview: Pressure (100)
		- Bottom Left:
			- Show Aplications Grid: Pressure (100)	
		- Bottom Right:
			- Show Desktop: Pressure (100)
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
	- Posição e Tamanho
		- Exibir o dock: Monitor primário
		- Mostrar em todos os monitore: On
		- Posição na tela: Embaixo
		- Ocultação inteligente: On
			- Ocultação: On
			- Esconder janela: Somente janelas maximizadas
			- Tempo de animação [s]: 0,150
			- Ocultar tempo limite [s]: 0,200
			- Mostrar tempo limite [s]: 0,250
		- Tamanho limite da dock: 90%
		- Tamanho limite do ícone: 38px
	- Lançadores
		- Mostrar aplicativos favoritos: On
		- Mostrar aplicativos em execução: On
			- Mostrar pré-visualização de janelas abertas: On
			- Isolar espaços de trabalho: On
		- Exibir ícone dos Aplicativos: Off
		- Mostrar lixeira: Off
		- Mostrar volumes e dispositivos montados: Off
	- Comportamento
		- Usar atalhos do teclado para ativar aplicativos: On
		- Ação do clique: Minimizar e mostrar pré-visualizações
			- Ação do Shift+Clique: Minimizar janela
			- Ação do clique do botão do meio: Iniciar nova instância
			- Ação do Shift+Clique do botão do meio: Iniciar nova instância
		- Ação da rolagem: Percorrer através das janelas
	- Aparência
		- Usar o tema do sistema: Off
		- Encolher o dash: On
		- Customizar a cor do dash: Off
- [Extension Update Notifier](https://extensions.gnome.org/extension/1166/extension-update-notifier/)
- [Impatience](https://extensions.gnome.org/extension/277/impatience/)
	- Speed scaling: 0.75
- [Lock Keys](https://extensions.gnome.org/extension/36/lock-keys/)
	- Estilo do indicador: Notificações somente
	- Notificações: Osd 
- [OpenWeather](https://extensions.gnome.org/extension/750/openweather/)
- [Transparent Top Panel](https://extensions.gnome.org/extension/2878/transparent-top-panel/)
- [Transparent Window Moving](https://extensions.gnome.org/extension/1446/transparent-window-moving/)
	- Opacity: 220
	- Animation time: 0,10
	- Transparent on moving: Yes
	- Transparent on resizing: Yes
- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)
- [WindowOverlay Icons](https://extensions.gnome.org/extension/302/windowoverlay-icons/)
	- Alinhamento: Centro
	- Tamanho: 100
	- Opacidade do ícone - foco: 255
	- Opacidade do ícone - foco: 190
- Ubuntu
	- [Desktop Icons](https://extensions.gnome.org/extension/1465/desktop-icons/)
	- [Ubuntu Appindicators](https://extensions.gnome.org/extension/1301/ubuntu-appindicators/) Off
	- [Ubuntu Dock](https://extensions.gnome.org/extension/1300/ubuntu-dock/) Off
