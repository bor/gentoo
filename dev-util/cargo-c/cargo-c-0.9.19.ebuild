# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

# Only bother defining this if the github tarball doesn't work!
# Otherwise just comment it out and things should Just Work (TM).
#MY_P="${P}+cargo-{CARGO_V}"

CRATES="
${MY_P}
adler-1.0.2
aho-corasick-0.7.20
aho-corasick-1.0.1
anstream-0.3.2
anstyle-1.0.0
anstyle-parse-0.2.0
anstyle-query-1.0.0
anstyle-wincon-1.0.1
anyhow-1.0.71
arrayvec-0.5.2
autocfg-1.1.0
base16ct-0.2.0
base64-0.13.1
base64ct-1.6.0
bitflags-1.3.2
bitmaps-2.1.0
block-buffer-0.10.4
bstr-1.4.0
bumpalo-3.12.1
bytesize-1.2.0
cargo-0.70.1
cargo-platform-0.1.2
cargo-util-0.2.3
cbindgen-0.24.3
cc-1.0.79
cfg-if-1.0.0
clap-4.2.7
clap_builder-4.2.7
clap_derive-4.2.0
clap_lex-0.4.1
colorchoice-1.0.0
commoncrypto-0.2.0
commoncrypto-sys-0.2.0
const-oid-0.9.2
core-foundation-0.9.3
core-foundation-sys-0.8.4
cpufeatures-0.2.7
crates-io-0.36.0
crc32fast-1.3.2
crypto-bigint-0.5.2
crypto-common-0.1.6
crypto-hash-0.3.4
ct-codecs-1.1.1
curl-0.4.44
curl-sys-0.4.61+curl-8.0.1
der-0.7.5
digest-0.10.6
ecdsa-0.16.6
ed25519-compact-2.0.4
either-1.8.1
elliptic-curve-0.13.4
env_logger-0.10.0
errno-0.3.1
errno-dragonfly-0.1.2
fastrand-1.9.0
ff-0.13.0
fiat-crypto-0.1.20
filetime-0.2.21
flate2-1.0.26
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
form_urlencoded-1.1.0
fwdansi-1.1.0
generic-array-0.14.7
getrandom-0.2.9
git2-0.16.0
git2-curl-0.17.0
glob-0.3.1
globset-0.4.10
group-0.13.0
hashbrown-0.12.3
heck-0.4.1
hermit-abi-0.3.1
hex-0.3.2
hex-0.4.3
hkdf-0.12.3
hmac-0.12.1
home-0.5.5
http-auth-0.1.8
humantime-2.1.0
idna-0.3.0
ignore-0.4.20
im-rc-15.1.0
indexmap-1.9.3
instant-0.1.12
io-lifetimes-1.0.10
is-terminal-0.4.7
itertools-0.10.5
itoa-1.0.6
jobserver-0.1.26
js-sys-0.3.61
lazycell-1.3.0
lazy_static-1.4.0
libc-0.2.142
libgit2-sys-0.14.1+1.5.0
libnghttp2-sys-0.1.7+1.45.0
libssh2-sys-0.2.23
libz-sys-1.1.9
linux-raw-sys-0.3.6
log-0.4.17
memchr-2.5.0
miniz_oxide-0.7.1
miow-0.5.0
num-traits-0.2.15
once_cell-1.17.1
opener-0.5.2
openssl-0.10.52
openssl-macros-0.1.1
openssl-probe-0.1.5
openssl-src-111.25.3+1.1.1t
openssl-sys-0.9.87
ordered-float-2.10.0
orion-0.17.4
os_info-3.7.0
p384-0.13.0
pasetors-0.6.6
pathdiff-0.2.1
pem-rfc7468-0.7.0
percent-encoding-2.2.0
pkcs8-0.10.2
pkg-config-0.3.26
primeorder-0.13.1
proc-macro2-1.0.56
quote-1.0.26
rand_core-0.6.4
rand_xoshiro-0.6.0
redox_syscall-0.2.16
redox_syscall-0.3.5
regex-1.8.1
regex-automata-0.1.10
regex-syntax-0.7.1
rfc6979-0.4.0
rustc-workspace-hack-1.0.0
rustfix-0.6.1
rustix-0.37.18
ryu-1.0.13
same-file-1.0.6
schannel-0.1.21
sec1-0.7.2
semver-1.0.17
serde-1.0.160
serde_derive-1.0.160
serde_ignored-0.1.7
serde_json-1.0.96
serde_spanned-0.6.1
serde-value-0.7.0
sha1-0.10.5
sha2-0.10.6
shell-escape-0.1.5
signature-2.1.0
sized-chunks-0.6.5
socket2-0.4.9
spki-0.7.1
strip-ansi-escapes-0.1.1
strsim-0.10.0
subtle-2.4.1
syn-1.0.109
syn-2.0.15
tar-0.4.38
tempfile-3.5.0
termcolor-1.2.0
thread_local-1.1.7
time-0.3.20
time-core-0.1.0
time-macros-0.2.8
tinyvec-1.6.0
tinyvec_macros-0.1.1
toml-0.5.11
toml-0.7.3
toml_datetime-0.6.1
toml_edit-0.19.8
typenum-1.16.0
unicode-bidi-0.3.13
unicode-ident-1.0.8
unicode-normalization-0.1.22
unicode-width-0.1.10
unicode-xid-0.2.4
url-2.3.1
utf8parse-0.2.1
vcpkg-0.2.15
version_check-0.9.4
vte-0.10.1
vte_generate_state_changes-0.1.1
walkdir-2.3.3
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.84
wasm-bindgen-backend-0.2.84
wasm-bindgen-macro-0.2.84
wasm-bindgen-macro-support-0.2.84
wasm-bindgen-shared-0.2.84
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows_aarch64_gnullvm-0.42.2
windows_aarch64_gnullvm-0.48.0
windows_aarch64_msvc-0.42.2
windows_aarch64_msvc-0.48.0
windows_i686_gnu-0.42.2
windows_i686_gnu-0.48.0
windows_i686_msvc-0.42.2
windows_i686_msvc-0.48.0
windows-sys-0.42.0
windows-sys-0.45.0
windows-sys-0.48.0
windows-targets-0.42.2
windows-targets-0.48.0
windows_x86_64_gnu-0.42.2
windows_x86_64_gnu-0.48.0
windows_x86_64_gnullvm-0.42.2
windows_x86_64_gnullvm-0.48.0
windows_x86_64_msvc-0.42.2
windows_x86_64_msvc-0.48.0
winnow-0.4.6
zeroize-1.6.0
"

inherit cargo

DESCRIPTION="Helper program to build and install c-like libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
if [[ -z ${MY_P} ]] ; then
	SRC_URI="https://github.com/lu-zero/cargo-c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
else
	S="${WORKDIR}/${MY_P}"
fi

SRC_URI+=" $(cargo_crate_uris)"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

RDEPEND="dev-libs/libgit2:=
	dev-libs/openssl:=
	net-libs/libssh2:=
	net-misc/curl[ssl]
	sys-libs/zlib"
DEPEND="${RDEPEND}"
BDEPEND=">=virtual/rust-1.67.0"

QA_FLAGS_IGNORED="usr/bin/cargo-capi usr/bin/cargo-cbuild usr/bin/cargo-ctest usr/bin/cargo-cinstall"

src_unpack() {
	cargo_src_unpack

	if [[ -n ${MY_P} ]] ; then
		tar -xf "${DISTDIR}"/"${MY_P}.crate" -C "${WORKDIR}" || die
	fi
}

src_configure() {
	# Some crates will auto-build and statically link C libraries(!)
	# Tracker bug #709568
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1
}
