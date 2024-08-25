# Use a imagem oficial do Ruby como base
FROM ruby:3.3.4-slim as base

# Configure o diretório de trabalho
WORKDIR /myapp


# Instale as dependências do sistema
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    libvips-dev \
    bash \
    libffi-dev \
    tzdata \
    postgresql-client \
    nodejs \
    npm \
    yarn \
    wget \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Instale libssl (certifique-se de que a URL é válida para sua versão do sistema)
RUN wget -q http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb && \
    rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Estágio de construção para reduzir o tamanho da imagem final
FROM base as build

# Adicione o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./
# Instale as gems
RUN bundle install
RUN bundle update

COPY Gemfile Gemfile.lock ./
# Copie o código da aplicação
COPY . .

# Verifique a instalação do Rails

# Estágio final para a imagem da aplicação
FROM base

# Copie os artefatos construídos: gems e aplicação
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /myapp /myapp

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/
# Exponha a porta 3000 para o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
