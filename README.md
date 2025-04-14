# NewsApp

NewsApp, iOS platformu için geliştirilmiş bir haber yönetim uygulamasıdır. Kullanıcılar haberleri görüntüleyebilir, admin kullanıcılar ise haber ekleyebilir, düzenleyebilir ve silebilir.

## Özellikler

- Kullanıcı Kimlik Doğrulama (Firebase Auth)
  - Giriş yapma
  - Kayıt olma
  - Şifre sıfırlama
  
- Haber Yönetimi
  - Haber listeleme
  - Haber detay görüntüleme
  
- Admin Paneli
  - Haber ekleme
  - Haber düzenleme
  - Haber silme

## Kullanılan Teknolojiler

- Swift
- UIKit
- Firebase
  - Authentication
  - Firestore
  - Storage
- Kingfisher
- MVVM-C Mimarisi

## Proje Yapısı

```
NewsApp/
├── App/
│   ├── AppDelegate
│   └── SceneDelegate
├── Data/
│   ├── Models/
│   └── Network/
├── Helpers/
│   └── Extensions/
├── Modules/
│   ├── AddNews/
│   ├── AdminNews/
│   ├── ContentList/
│   ├── Home/
│   ├── HomeDetail/
│   ├── Settings/
│   ├── SignIn/
│   ├── SignUp/
│   ├── Splash/
│   ├── TabBar/
│   └── UpdateNews/
├── SupportingFiles/
│   ├── GoogleService-Info.plist
│   └── Info.plist
└── Resources/
    ├── Images.assets
    └── Colors.assets
```

## Mimari

Proje MVVM-C (Model-View-ViewModel-Coordinator) mimarisi kullanılarak geliştirilmiştir:

- **Model**: Veri yapılarını ve iş mantığını içerir
- **View**: Kullanıcı arayüzü bileşenlerini içerir
- **ViewModel**: View ve Model arasındaki iletişimi yönetir
- **Contracts**: Ekranlar arası geçişleri yönetir

## Video
https://github.com/user-attachments/assets/66a74bb9-d8f7-4fad-a114-44ae49b191b6

### Kullanıcı Girişi
- Email ve şifre ile giriş
- Kayıt olma
- Şifremi unuttum

### Ana Sayfa
- Haberlerin liste görünümü
- Haber detay sayfası
- Tarih bazlı sıralama

### Admin Paneli
- Haber ekleme formu
- Haber düzenleme
- Haber silme
- İçerik yönetimi

## Kurulum

1. Projeyi klonlayın
```bash
git clone https://github.com/username/NewsApp.git
```

2. Firebase yapılandırma dosyasını ekleyin

3. GoogleService-Info.plist dosyasını projeye ekleyin
   
4. Xcode ile projeyi açın ve çalıştırın

## Gereksinimler
* iOS 17.0+
* Xcode 16.0+
* Swift 5.0+
* SPM

## Kullanılan Kütüphaneler
* Firebase/Auth
* Firebase/Firestore
* Firebase/Storage
* Kingfisher
