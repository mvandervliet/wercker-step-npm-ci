#!/bin/bash

main() {
  if [ "$WERCKER_NPM_CI_USE_CACHE" == "true" ]; then
    info "Using wercker cache"
    setup_cache
  fi

  set +e
  npm_ci
  set -e

  success "Finished npm ci"
}

setup_cache() {
  debug 'Creating $WERCKER_CACHE_DIR/wercker/npm'
  mkdir -p "$WERCKER_CACHE_DIR/wercker/npm"
  
  debug 'Configuring npm to use wercker cache'
  npm config set cache "$WERCKER_CACHE_DIR/wercker/npm"
}

clear_cache() {
  warn "Clearing npm cache"
  npm cache clear
  
  # make sure the cache contains something, so it will override cache that get's stored
  debug 'Creating $WERCKER_CACHE_DIR/wercker/npm'
  mkdir -p "$WERCKER_CACHE_DIR/wercker/npm"
  printf keep > "$WERCKER_CACHE_DIR/wercker/npm/.keep"
}

npm_ci() {
  local retries=2;
  for try in $(seq "$retries"); do
    info "Starting npm ci, try: $try"
    npm ci $WERCKER_NPM_CI_OPTIONS && return;

    if [ "$WERCKER_NPM_CI_CLEAR_CACHE_ON_FAILED" == "true" ]; then
      clear_cache
    fi
  done

  fail "Failed to successfully execute npm ci, retries: $retries"
}

main;
