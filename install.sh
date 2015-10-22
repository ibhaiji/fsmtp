#!/bin/bash

# Test if running with "bash" interpreter.
if [ -z "$BASH" ]; then
	bash "$0" "$@"
	exit $?
fi

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
destName="fsmtp"
destBin="/usr/bin/${destName}"
destLnk="/usr/share/applications/${destName}.desktop"

chmod a+x ${DIR}/fsmtp

if [ -f "$destBin" ]; then
  echo "$destBin already installed!"
else
  echo "Install $destBin..."

	echo "#!/bin/bash" > $destBin
	echo "${DIR}/fsmtp \"\$@\"" >> $destBin

	chmod a+x $destBin
	hash -r
fi

if [ -f "$destLnk" ]; then
  echo "$destLnk already installed!"
else
  echo "Install $destLnk..."

  echo "[Desktop Entry]" > $destLnk
  echo "Name=fSMTP - FakeSMTP" >> $destLnk
  echo "Comment=fSMTP - FakeSMTP" >> $destLnk
  echo "Exec=fsmtp ui" >> $destLnk
  echo "Icon=mail-message-new.png" >> $destLnk
  echo "Terminal=false" >> $destLnk
  echo "Type=Application" >> $destLnk
  echo "Encoding=UTF-8" >> $destLnk
  echo "Categories=Network;Application;Mail;Smtp" >> $destLnk
fi
