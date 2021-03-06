TERMUX_PKG_HOMEPAGE=https://www.privoxy.org
TERMUX_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
TERMUX_PKG_VERSION=3.0.27
TERMUX_PKG_SHA256=67540360e28c881c892481d1a224632f5b58569e003285467fea6e4b59316378
TERMUX_PKG_SRCURL=https://www.privoxy.org/sf-download-mirror/Sources/$TERMUX_PKG_VERSION%20%28stable%29/privoxy-$TERMUX_PKG_VERSION-stable-src.tar.gz
TERMUX_PKG_CONFFILES='etc/privoxy/config etc/privoxy/match-all.action etc/privoxy/trust etc/privoxy/user.action etc/privoxy/user.filter etc/privoxy/default.action etc/privoxy/default.filter'
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--sysconfdir=$TERMUX_PREFIX/etc/privoxy"
TERMUX_PKG_DEPENDS="pcre"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_KEEP_SHARE_DOC=yes

termux_step_pre_configure() {
    autoheader
    autoconf

    # avoid 'aarch64-linux-android-strip': No such file or directory
    ln -s "$TERMUX_STANDALONE_TOOLCHAIN/bin/$STRIP" .
}

termux_step_post_make_install() {
    # delete link created to avoid errors
    rm -f "$TERMUX_PREFIX/sbin/$STRIP"
}

termux_step_post_massage() {
    # copy default config files
    for f in $TERMUX_PKG_CONFFILES; do
        cp "$TERMUX_PKG_SRCDIR/$(basename $f)" "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$f"
    done
}
