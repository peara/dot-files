#! /bin/bash

TMUX=('.tmux.conf')
TMUXINATOR=('.tmuxinator.zsh')
ZSH=('.zshrc')
# OH_MY_ZSH=('.oh-my-zsh')


CONFS=(${TMUX[@]} ${TMUXINATOR[@]} ${ZSH[@]})

for app in "${CONFS[@]}"; do
  for file in "${app[@]}"; do
    TNAME="${HOME}/${file}"
    FNAME=${file#.}
    echo "Linking ${TNAME} to ${FNAME}"
    FTYPE=$(file -b "$TNAME")
    echo $FTYPE
    if [[ $FTYPE =~ "symbolic link" ]]; then
      echo "Skip symbolic link"
    else
      echo "Creating backup for ${TNAME}"
      cp -f ${TNAME} ${TNAME}.bak
      echo "Moving and creating symbolic link for ${TNAME}"
      mv ${TNAME} ${FNAME} && ln -s ${FNAME} ${TNAME}
    fi
  done
done

