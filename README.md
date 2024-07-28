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


2. เมื่อกดเข้ามาที่หน้าหลักของเกม ผู้เล่นสามารถเลือกจำนวนตารางที่ต้องการและขนาดการเรียงของ OX รวมถึงเลือกเล่นกับผู้เล่นคนอื่นหรือบอท

<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_scale.png" alt="Description of image" width="300" />
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_win_by.png" alt="Description of image" width="300" />
</p>

3. เมื่อกด "Start" ในหน้าหลัก ผู้เล่นสามารถ Zoom in, Zoom out และเลื่อนตารางไปยังตำแหน่งที่ต้องการได้

<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/first_page_zoom.png" alt="Description of image" width="300" />
</p>

4. หน้าดูประวัติการเล่นสามารถให้ผู้เล่นเลือกดูการเล่นในวันและเวลาที่ต้องการ และสามารถล้างประวัติการเล่นได้

 
<p align="center">
  <img src="https://github.com/JOJODOll/Infinite-Tic-Tac-Toe/raw/main/PICTURE/history.png" alt="Description of image" width="300" />
</p>


## algorithm ในการตรวจ XO



