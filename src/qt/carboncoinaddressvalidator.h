// Copyright (c) 2011-2014 The Carboncoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CARBONCOIN_QT_CARBONCOINADDRESSVALIDATOR_H
#define CARBONCOIN_QT_CARBONCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class CarboncoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CarboncoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Carboncoin address widget validator, checks for a valid carboncoin address.
 */
class CarboncoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CarboncoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // CARBONCOIN_QT_CARBONCOINADDRESSVALIDATOR_H
