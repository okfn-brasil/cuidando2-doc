

## Check context

# Supposing Ubuntu 14 LTS, git 1.9, jsV8 4.6, nodeJs 5.2, npm 3.5
lsb_release -a
git --version
node -p process.versions.v8
nodejs --version
npm -v

## To clone and install project

git clone https://github.com/okfn-brasil/cuidando2.git

cd cuidando2

npm i
npm run dev

# after all, use http://localhost:5001 at browser or  http://localhost:5001/webpack-dev-server




