# GitHub, Jenkins ve Docker ile Otomatik Yayınlama

Bu proje, Spring Boot uygulamasinin GitHub'a her `push` sonrasi Jenkins tarafindan otomatik olarak build edilip Docker container olarak yeniden ayaga kaldirilmasi icin hazirlandi.

## Proje Icerigi

- `Spring Boot` tabanli basit bir REST uygulamasi
- `Jenkinsfile` ile tanimli CI/CD pipeline
- `Dockerfile` ile container image olusturma
- `scripts/deploy.sh` ile eski container'i silip yeni surumu calistirma

## Uygulamayi Lokal Calistirma

```bash
./mvnw clean package
docker build -t cicd-demo:latest .
docker run -d --name cicd-demo-app -p 8080:8080 cicd-demo:latest
```

Test etmek icin:

```bash
curl http://localhost:8080/
curl http://localhost:8080/health
```

## Jenkins Pipeline Mantigi

`Jenkinsfile` su adimlari calistirir:

1. GitHub reposundan kodu alir.
2. `./mvnw clean test package` ile projeyi build eder.
3. Docker image olusturur.
4. Eski container'i durdurup siler.
5. Yeni image ile container'i tekrar ayaga kaldirir.

## Jenkins Uzerinde Kurulum

1. Bu klasoru GitHub'a yukleyin.
2. Bilgisayarinizdaki Jenkins'te `Pipeline` tipinde yeni bir job olusturun.
3. `Pipeline script from SCM` secin.
4. `SCM` olarak `Git` secin ve GitHub repo adresinizi girin.
5. `Script Path` alanina `Jenkinsfile` yazin.
6. Jenkins kullanicisinin Docker komutlarini calistirabildiginden emin olun.

## GitHub Push Ile Tetikleme

Iki farkli yontemden birini kullanabilirsiniz:

### 1. Webhook ile

- Jenkins job ayarlarinda `GitHub hook trigger for GITScm polling` secenegini aktif edin.
- GitHub reposunda `Settings > Webhooks > Add webhook` menusu uzerinden su adresi ekleyin:

```text
http://JENKINS-SUNUCU-ADRESI:8080/github-webhook/
```

### 2. Poll SCM ile

Webhook kullanmak istemezseniz job ayarlarinda `Poll SCM` secenegini aktif edip su ifadeyi kullanin:

```text
H/2 * * * *
```

Bu ayar Jenkins'in repoyu yaklasik her 2 dakikada bir kontrol etmesini saglar.

## Odev Sunumu Icin Kisa Senaryo

1. Uygulamayi ilk kez push edin.
2. Jenkins build'in otomatik basladigini gosterin.
3. `app.message` degerini degistirin.
4. Tekrar push edin.
5. Jenkins'in yeni build aldigini ve Docker container'i guncelledigini gosterin.
6. `curl http://localhost:8082/` ile yeni mesaji kanit olarak gosterin.
