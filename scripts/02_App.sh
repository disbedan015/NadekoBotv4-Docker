mkdir nadeko || true && wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.4/5.1.4-linux-x64-build.tar && tar xf 5.1.4-linux-x64-build.tar && mv -f nadekobot-linux-x64/* /nadeko/ || true && rm 5.1.4-linux-x64-build.tar || true && rm -rf nadekobot-linux-x64/ || true && chmod +x /nadeko/NadekoBot || true