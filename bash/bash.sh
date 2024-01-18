keytool -genkey -v -keystore /Users/hesham/Masaj-mobile/android/app/release.keystore -storepass masaj_app1234 -alias androidreleasekey -keypass masaj_app1234 -keyalg RSA -keysize 2048 -validity 10000 -storetype JKS -dname "CN=Masaj, OU=Masaj, O=Masaj Co, L=Kuwait, S=Kuwait, C=Kuwait"
echo "storePassword=masaj_app1234" > /Users/hesham/Masaj-mobile/android/key.properties
echo "keyPassword=masaj_app1234" >> /Users/hesham/Masaj-mobile/android/key.properties
echo "keyAlias=androidreleasekey" >> /Users/hesham/Masaj-mobile/android/key.properties
echo "storeFile=/Users/hesham/Masaj-mobile/android/app/release.keystore" >> /Users/hesham/Masaj-mobile/android/key.properties
echo "key.store=release.keystore" >> /Users/hesham/Masaj-mobile/android/key.properties
echo "key.alias=androidreleasekey" >> /Users/hesham/Masaj-mobile/android/key.properties

# get relase sha1 key
keytool -list -v -keystore /Users/hesham/Masaj-mobile/android/app/release.keystore -storepass masaj_app1234 -alias androidreleasekey -keypass masaj_app1234
# get debug sha1 key
keytool -list -v -keystore /Users/hesham/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android