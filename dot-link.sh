#! /bin/bash

TMUX=('.tmux.conf')
TMUXINATOR=('.tmuxinator.zsh' '.config/tmuxinator')
ZSH=('.zshrc')
# OH_MY_ZSH=('.oh-my-zsh')


CONFS=(${TMUX[@]} ${TMUXINATOR[@]} ${ZSH[@]})

for app in "${CONFS[@]}"; do
  for file in "${app[@]}"; do
    TNAME="${HOME}/${file}"
    FTYPE=$(file -b "$TNAME")
    echo "Linking ${TNAME} - $FTYPE"
    if [[ $FTYPE =~ "symbolic link" ]]; then
      echo "--> Skip symbolic link"
    elif [[ -z $FTYPE ]]; then
      echo "--> Setting not found. Checking for existence of application"
      echo "   TODO: If found, then create symlink"
      echo "   TODO: Else, do nothing or ask for installing"
    elif [[ $FTYPE =~ "directory" ]]; then
      echo "--> Creating backup for ${TNAME}"
      cp -rf ${TNAME} ${TNAME}-bak
      FNAME="`pwd`/${file##*/}"
      echo "--> Moving to ${FNAME} and creating symbolic link"
      mv ${TNAME} ${FNAME} && ln -s ${FNAME} ${TNAME}
    else
      echo "--> Creating backup for ${TNAME}"
      cp -f ${TNAME} ${TNAME}.bak
      FNAME="`pwd`/${file#.}"
      echo "--> Moving to ${FNAME} and creating symbolic link"
      mv ${TNAME} ${FNAME} && ln -s ${FNAME} ${TNAME}
    fi
  done
done

