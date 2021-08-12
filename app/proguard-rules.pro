# Disable file renaming
#-renamesourcefileattribute SourceFile
-keepparameternames
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,EnclosingMethod

-dontobfuscate

-keep class com.android.car.** { *;}
#-keep class com.renault.car.boschradar.sensoris.** { *;}

# Reports for debugging (use full paths for output file)
#-printmapping <your_path>/BoschRadar.map
#-printconfiguration <your_path>/configuration.txt
#-printusage <your_path>/usage.txt
#-printseeds <your_path>/seeds.txt

-dontwarn kotlinx.android.parcel.Parceler*
-dontwarn alliancex.car.**
-dontwarn alliance.car.**
-dontwarn alliancex.car.core.**

-dontwarn com.android.car.***
-dontwarn android.support.**

# Preverification is irrelevant for the dex compiler and the Dalvik VM.

-dontpreverify

# Keep a fixed source file attribute and all line number tables to get line
# numbers in the stack traces.

# Disable file renaming
# -renamesourcefileattribute SourceFile
# -keepattributes SourceFile,LineNumberTable

# RemoteViews might need annotations.
-keepattributes Annotation
-keepattributes *Annotation*

# Preserve all fundamental application classes.

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver

# Preserve all View implementations, their special context constructors, and
# their setters.

-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}

# Preserve all classes that have special context constructors, and the
# constructors themselves.

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

# Preserve all classes that have special context constructors, and the
# constructors themselves.

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# Preserve the special fields of all Parcelable implementations.

-keepclassmembers class * implements android.os.Parcelable {
    static android.os.Parcelable$Creator CREATOR;
}

# Preserve static fields of inner classes of R classes that might be accessed
# through introspection.

-keepclassmembers class **.R$* {
  public static <fields>;
}

# The Android Compatibility library references some classes that may not be
# present in all versions of the API, but we know that's ok.

-dontwarn android.support.**

# Preserve all native method names and the names of their classes.

-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve the special static methods that are required in all enumeration
# classes.

-keepclassmembers class * extends java.lang.Enum {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Explicitly preserve all serialization members. The Serializable interface
# is only a marker interface, so it wouldn't save them.

-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
