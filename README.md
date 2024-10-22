# Infinite-Tic-Tac-Toe

## Overview
Infinite Tic Tac Toe เป็นแอปพลิเคชัน OX ที่ให้ผู้เล่นสามารถเลือกขนาดตารางและความยาวของ OX ที่ต้องการเล่นได้ นอกจากนี้ยังสามารถเลือกเล่นกับผู้เล่นคนอื่นหรือบอทได้ และยังมีฟีเจอร์ให้ดูข้อมูลการเล่นย้อนหลังได้


## Features
- เลือกขนาดตารางและจำนวนความยาวของ OX ที่ต้องการเล่น
- เลือกเล่นกับผู้เล่นคนอื่นหรือบอท
- สามารถซูมตารางให้มีขนาดใหญ่ขึ้นหรือเล็กลงได้
- สามารถเลื่อนตารางไปยังตำแหน่งที่ต้องการได้
- ดูข้อมูลการเล่นย้อนหลัง


## Set up
1. เวอร์ชันของ Flutter ที่ใช้: **V 3.22.0**
2. การจัดการสถานะ: **Provider**
3. การเก็บข้อมูล: **SQLite**


## Dependencies
- `cupertino_icons: ^1.0.6`
- `provider: ^6.1.2`
- `google_fonts: 6.1.0`
- `font_awesome_flutter: ^10.7.0`
- `vector_math: ^2.1.4`
- `sqflite: ^2.3.3+1`
- `intl: ^0.19.0`
- `flutter_launcher_icons: ^0.13.1`
- `rename_app: ^1.6.1`


## ตัวอย่างการทำงาน
1. หน้าแรกจะเป็นแถบเมนูที่มีตัวเลือก "New Game" และ "History"
<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page.png" alt="Description of image" width="300" />
</p>
<p align="center">
  รูป หน้าแรก
</p>


2. เมื่อกดเข้ามาที่หน้าหลักของเกม ผู้เล่นสามารถเลือกจำนวนตารางที่ต้องการและขนาดการเรียงของ OX รวมถึงเลือกเล่นกับผู้เล่นคนอื่นหรือบอท
<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_scale.png" alt="Description of image" width="300" />
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_win_by.png" alt="Description of image" width="300" />
</p>
<p align="center">
  รูป เลือกขนาดตาราง และ เลือกความยาวของ OX
</p>


3. เมื่อกด "Start" ในหน้าหลัก ผู้เล่นสามารถ Zoom in, Zoom out และเลื่อนตารางไปยังตำแหน่งที่ต้องการได้
<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_zoom.png" alt="Description of image" width="300" />
</p>
<p align="center">
  รูป การซูมและเลื่อน
</p>


4. หน้าดูประวัติการเล่นสามารถให้ผู้เล่นเลือกดูการเล่นในวันและเวลาที่ต้องการ และสามารถล้างประวัติการเล่นได้
<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/history.png" alt="Description of image" width="300" />
</p>
<p align="center">
   รูป หน้าประวัติ
</p>

## algorithm ในการตรวจ XO

1. ใช้การ convolution ในการตรวจ กรณีต่างๆ
 - โดยปกติแล้ว convolution จะเป็นการเลื่อนสัญญาณเพื่อการให้ได้ผมลัพท์บางอย่างออกมาเช่น การกรองสัญญาณ หรือ การทำให้เบลอ ผู้จัดทำเล็งเห็นว่าสามารถทำมาประยุกต์ใช้การตรวจกรณีต่างๆของ XO ได้จึงทำวิธีดังกล่าวมาเข้ามาใช้
  <p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/convolution-1-fast_orig.gif" alt="Description of image" width="300" />
</p>

<p align="center">
   รูป ตัวอย่าง convolution
</p>
2. ตัวอย่าง
 - ใช้ vector_dart เพื่อสร้าง vector ตาราง OX จากนั้นสร้าง vector ขอความยาวของ OX ที่จะใช้ตรวจ
 - จากนั้นรับ [R][C] ของตาราง OX ที่ผู้เล่นกดเข้ามา  แล้วนำมาเลื่อนการตรวจใน แนวแกนตั้ง, แกนนอน และ แกนทะแยงทั้งสองข้าง เลื่อนตั้งแต่ ระยะ   [R - ความยาวOX ที่จะใช้ตรวจ] จนถึง [R + ความยาวOX ที่จะใช้ตรวจ] ถ้า มีกรณีที่เป็นจริง ทั้งหมดตามความยาวก็จะตรวจว่า ชนะเกมในตานั้นๆ
  <p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/code_check_win.png" alt="Description of image" width="500" />
</p>
 <p align="center">
   รูป ตัวอย่าง code การตรวจกรณี OX
</p>

## VDO ตัวอย่าง
[ดูวิดีโอตัวอย่าง](https://www.youtube.com/watch?v=-TIv0mid5U4)

<p align="center">
  <a href="https://youtu.be/-TIv0mid5U4" target="_blank">
    <img src="https://img.youtube.com/vi/-TIv0mid5U4/0.jpg" alt="Video Thumbnail" width="400" />
  </a>
</p>

## if you cannot clone or something errors
[Link_Download](https://drive.google.com/file/d/19Z00eHu6EXKHKE4pjrHFTP0w8ATAaoHb/view?usp=drive_link)




