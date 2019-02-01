#! /bin/bash

TMUX=('.tmux.conf')
TMUXINATOR=('.tmuxinator.zsh')
ZSH=('.zshrc')
# OH_MY_ZSH=('.oh-my-zsh')


CONFS=(${TMUX[@]} ${TMUXINATOR[@]} ${ZSH[@]})

for app in "${CONFS[@]}"; do
  for file in "${app[@]}"; do
    TNAME="${HOME}/${file}"
    FNAME="`pwd`/${file#.}"
    echo "Linking ${TNAME} to ${FNAME}"
    FTYPE=$(file -b "$TNAME")
    echo $FTYPE
    if [[ $FTYPE =~ "symbolic link" ]]; then
      echo "Skip symbolic link"
    elif [[ -z $FTYPE ]]; then
      echo "Setting not found. Checking for existence of application"
      echo "If found, then create symlink"
      echo "Else, do nothing or ask for installing"
    else
      echo "Creating backup for ${TNAME}"
      cp -f ${TNAME} ${TNAME}.bak
      echo "Moving to ${FNAME} and creating symbolic link for ${TNAME}"
      mv ${TNAME} ${FNAME} && ln -s ${FNAME} ${TNAME}
    fi
  done
done

