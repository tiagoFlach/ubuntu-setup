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
|----------	|---------	|------------		|-----------	|-------------	|
| sda1			| 512 MB		| fat32					| /boot/efi		| Boot				|
| sda2			| 9,8 GB			| NTFS					|				| Data Safe			|
| sda3			| 100 GB		| NTFS					|				| Windows			|
| sda4			| 8 GB			| linux-swap			|				| Swap				|
| sda5			| 60 GB			| ext4					| /				| Raiz Ubuntu		|

<br />

- HDD
	- Windows - 330 GB
	- Ubuntu - 600 GB

| Partição		| Tamanho		| Sistema de Arquivos	| Montagem		| Rótulo			|
|----------	|---------	|------				|----------	|-------------	|
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
	- **Microsoft Office**
	- MuseScore
	- Netflix
	- PopCorn Time
	- Skype
	- Simplenote
	- Spotify
	- Steam
	- Sublime Text
	- TuneIn Radio
	- VLC
	- **VirtualBox**
	- WhatsApp

<br />

- UBUNTU
	- Discord
	- FileZilla
	- Firefox
	- Google Chrome
	- **Google Earth Pro**
	- Gimp
	- LibreOffice
	- MuseScore
	- Odio
	- **PopCorn Time**
	- Skype
	- Simplenote
	- Spotify
	- Stellarium
	- Stacer
	- Sublime Text
	- Synaptic
	- TimeShift
	- VLC
	- VirtualBox
	- **WPS Office**