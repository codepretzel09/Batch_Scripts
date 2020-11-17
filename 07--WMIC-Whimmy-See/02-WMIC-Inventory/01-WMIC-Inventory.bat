@Echo off
echo 	^<HTML^>^<HEAD^>^<TITLE^>WMIC Inventory^</TITLE^>^</HEAD^>	> list.html
echo	^<BODY BGCOLOR="#FFFFFF" TEXT="#000000" LINK="#0000FF" VLINK="#800080"^>		>> list.html
echo	^<h1 align="center"^>^<b^>^<font face="Arial" size="+4" color="#003366"^>WMIC Inventory^</font^>^</b^>^</h1^>		>> list.html
echo ^<h4 align="center"^>^<b^>^<font face="Arial" size="+1" color="#660000"^>^<BR^>Inventory Scan run at: %time% - %date% ^</font^>^</b^>^</h4^> >> list.html
echo	^<p align="center"^>^<table border="1" width="600"^>					>> list.html
echo	^<tr^>^<td^>^<B^>System Name^</td^>		>> list.html
echo	^<td^>^<B^>ProductID^</td^>			>> list.html
echo	^<td^>^<B^>OS Info^</td^>			>> list.html
echo	^<td^>^<B^>System Info^</td^>			>> list.html
echo	^<td^>^<B^>Patches^</td^>			>> list.html
echo	^<td^>^<B^>Drive Volume Info^</td^>		>> list.html
echo	^<td^>^<B^>Motherboard^</td^>			>> list.html
echo	^<td^>^<B^>BIOS^</td^>				>> list.html
echo	^<td^>^<B^>Network Interfaces^</td^>		>> list.html
echo	^<td^>^<B^>Services^</td^>			>> list.html
echo	^<td^>^<B^>Users^</td^>				>> list.html
echo	^<td^>^<B^>Slots^</td^>^</B^>^</tr^>^</p^>	>> list.html
for /F %%a in (pclist.txt) do (
	echo Retrieving inventory from: %%a
	wmic /Failfast:on /node:"%%a" /output:"%%a_productid.html" csproduct list full /format:hform
	wmic /Failfast:on /node:"%%a" /output:"%%a_OS.html" OS Get /All /format:hform
	wmic /Failfast:on /node:"%%a" /output:"%%a_system.html" COMPUTERSYSTEM list BRIEF /format:hform
	wmic /Failfast:on /node:"%%a" /output:"%%a_qfe.html" QFE where "Description<>''" Get /All /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_drives.html" logicaldisk get caption, description, filesystem, size, freespace, compressed /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_motherboard.html" BASEBOARD list FULL /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_bios.html" BIOS list brief /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_nic.html" NIC list brief /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_services.html" SERVICE list brief /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_users.html" USERACCOUNT list brief /format:htable
	wmic /Failfast:on /node:"%%a" /output:"%%a_slot.html" SYSTEMSLOT list brief /format:htable
	
	echo ^<tr^>^<td^>%%a^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_productid.html"^>ProductID^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_OS.html"^>OS Info^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_system.html"^>System Info^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_QFE.html"^>Patches^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_drives.html"^>Drive Volumes^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_motherboard.html"^>Motherboard^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_bios.html"^>BIOS^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_nic.html"^>Network Interfaces^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_services.html"^>Services^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_users.html"^>Users^</a^>^</td^> >>list.html
	echo     ^<td^>^<a href="%%a_slot.html"^>Slots^</a^>^</td^> >>list.html
	echo ^</tr^> >>list.html
)
echo ^</font^>^</b^>^<BR^>^</p^> >>list.html
list.html
