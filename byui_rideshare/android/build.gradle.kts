buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add the Android Gradle Plugin dependency here
        classpath("com.android.tools.build:gradle:8.9.2")
        classpath(kotlin("gradle-plugin", version = "1.9.20"))
    }
}

plugins {
    id("com.google.gms.google-services") version "4.4.2" apply false
}

repositories {

}
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}