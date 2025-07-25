#!/bin/bash

# ایجاد پوشه lib اگر وجود ندارد
mkdir -p lib

# ایجاد پوشه موقت برای ساخت JAR
mkdir -p temp_jar/gg/essential/network/connectionmanager/cosmetics
mkdir -p temp_jar/gg/essential/network/connectionmanager/handler/cosmetics
mkdir -p temp_jar/gg/essential/connectionmanager/common/packet/cosmetic
mkdir -p temp_jar/gg/essential/cosmetics/model
mkdir -p temp_jar/gg/essential/event/client
mkdir -p temp_jar/gg/essential/gui/elementa/state/v2

# ایجاد فایل‌های Mock Java
cat > temp_jar/gg/essential/network/connectionmanager/cosmetics/CosmeticsManager.java << 'EOF'
package gg.essential.network.connectionmanager.cosmetics;
import gg.essential.event.client.ClientTickEvent;
public class CosmeticsManager {
    public void unlockAllCosmetics() {}
    public void tick(ClientTickEvent event) {}
}
EOF

cat > temp_jar/gg/essential/network/connectionmanager/handler/cosmetics/ServerCosmeticsPopulatePacketHandler.java << 'EOF'
package gg.essential.network.connectionmanager.handler.cosmetics;
import gg.essential.network.connectionmanager.ConnectionManager;
import gg.essential.connectionmanager.common.packet.cosmetic.ServerCosmeticsPopulatePacket;
public class ServerCosmeticsPopulatePacketHandler {
    public void onHandle(ConnectionManager cm, ServerCosmeticsPopulatePacket packet) {}
}
EOF

cat > temp_jar/gg/essential/network/connectionmanager/ConnectionManager.java << 'EOF'
package gg.essential.network.connectionmanager;
public class ConnectionManager {}
EOF

cat > temp_jar/gg/essential/connectionmanager/common/packet/cosmetic/ServerCosmeticsPopulatePacket.java << 'EOF'
package gg.essential.connectionmanager.common.packet.cosmetic;
public class ServerCosmeticsPopulatePacket {}
EOF

cat > temp_jar/gg/essential/cosmetics/model/Cosmetic.java << 'EOF'
package gg.essential.cosmetics.model;
public class Cosmetic {
    public String getType() { return ""; }
}
EOF

cat > temp_jar/gg/essential/event/client/ClientTickEvent.java << 'EOF'
package gg.essential.event.client;
public class ClientTickEvent {}
EOF

cat > temp_jar/gg/essential/gui/elementa/state/v2/MutableState.java << 'EOF'
package gg.essential.gui.elementa.state.v2;
public class MutableState<T> {
    public void set(T value) {}
}
EOF

# کامپایل فایل‌های Java
cd temp_jar
javac -cp . $(find . -name "*.java")

# حذف فایل‌های .java و نگه داشتن فقط .class
find . -name "*.java" -delete

# ساخت JAR فایل
jar cf ../lib/essential.mock.jar .

# برگشت به پوشه اصلی و حذف پوشه موقت
cd ..
rm -rf temp_jar

echo "فایل essential.mock.jar با موفقیت ساخته شد!"
ls -la lib/essential.mock.jar
