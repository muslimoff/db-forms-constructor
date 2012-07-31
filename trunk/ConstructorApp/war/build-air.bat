rem #adt -certificate -cn SelfSigned 1024-RSA sampleCert.pfx samplePassword
rem #start adt -certificate -cn SelfSigned 1024-RSA sampleCert.pfx q
adt -package -storetype pkcs12 -keystore sampleCert.pfx ConstructorApp.air ConstructorApp-air.xml AIRAliases.js ConstructorApp-air-frame.html constructorapp WEB-INF\constructorapp.connections.xml ConstructorApp.css ConstructorApp-air.html