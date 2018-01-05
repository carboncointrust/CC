#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CARBONCOIND=${CARBONCOIND:-$SRCDIR/carboncoind}
CARBONCOINCLI=${CARBONCOINCLI:-$SRCDIR/carboncoin-cli}
CARBONCOINTX=${CARBONCOINTX:-$SRCDIR/carboncoin-tx}
CARBONCOINQT=${CARBONCOINQT:-$SRCDIR/qt/carboncoin-qt}

[ ! -x $CARBONCOIND ] && echo "$CARBONCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
CARBONVER=($($CARBONCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for carboncoind if --version-string is not set,
# but has different outcomes for carboncoin-qt and carboncoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$CARBONCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $CARBONCOIND $CARBONCOINCLI $CARBONCOINTX $CARBONCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CARBONVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CARBONVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
