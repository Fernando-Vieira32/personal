# Use a imagem oficial do Ruby como base
FROM ruby:3.3.4-slim

# Instale as dependências do sistema e do npm
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Configure o diretório de trabalho
WORKDIR /myapp

# Adicione o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instale as gemas
RUN bundle install

# Adicione o restante do código da aplicação
COPY . .

# Instale as dependências do npm
RUN npm install

# Compile os ativos do Rails
RUN rails assets:precompile

# Exponha a porta 3000 para o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
