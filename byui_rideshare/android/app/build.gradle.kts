plugins {
    id("com.android.application")
    kotlin("android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Good: Applied *after* android and kotlin, and present here.
}

android {
    namespace = "com.example.byui_rideshare"
    compileSdk = flutter.compileSdkVersion // Typically an integer, e.g., 33 or 34
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString() // Or "11"
    }

    defaultConfig {
        applicationId = "com.example.byui_rideshare"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    // ... build types ...
}

flutter {
    source = "../.."
}
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.13.0"))
    implementation("com.google.firebase:firebase-analytics")
}