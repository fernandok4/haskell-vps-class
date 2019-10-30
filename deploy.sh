git add . &&
git commit -am $1 &&
git push origin master &&
ssh root@164.132.227.48 <<EOF
cd haskell-vps-class &&
git pull origin master &&
stack build &&
lsof -i:80 -Fp | sed 's/^p//' | head -n -1 | xargs kill -9;
nohup stack exec aulahaskell > /dev/null
echo "DEPLOY FINISHED"
EOF

## lsof -i:80 -Fp -> verifica se tem alguem rodando na porta 80
