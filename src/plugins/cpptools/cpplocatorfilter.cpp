/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
****************************************************************************/

#include "cpplocatorfilter.h"
#include "cppmodelmanager.h"

#include <QStringMatcher>

using namespace CppTools::Internal;

CppLocatorFilter::CppLocatorFilter(CppLocatorData *locatorData)
    : m_data(locatorData)
{
    setId("Classes and Methods");
    setDisplayName(tr("C++ Classes and Methods"));
    setShortcutString(QString(QLatin1Char(':')));
    setIncludedByDefault(false);
}

CppLocatorFilter::~CppLocatorFilter()
{
}

Locator::FilterEntry CppLocatorFilter::filterEntryFromModelItemInfo(const CppTools::ModelItemInfo &info)
{
    const QVariant id = qVariantFromValue(info);
    Locator::FilterEntry filterEntry(this, info.symbolName, id, info.icon);
    filterEntry.extraInfo = info.type == ModelItemInfo::Class || info.type == ModelItemInfo::Enum
        ? info.shortNativeFilePath()
        : info.symbolType;

    return filterEntry;
}

void CppLocatorFilter::refresh(QFutureInterface<void> &future)
{
    Q_UNUSED(future)
}

QList<QList<CppTools::ModelItemInfo> > CppLocatorFilter::itemsToMatchUserInputAgainst() const
{
    return QList<QList<CppTools::ModelItemInfo> >()
        << m_data->classes()
        << m_data->functions()
        << m_data->enums();
}

static bool compareLexigraphically(const Locator::FilterEntry &a,
                                   const Locator::FilterEntry &b)
{
    return a.displayName < b.displayName;
}

QList<Locator::FilterEntry> CppLocatorFilter::matchesFor(QFutureInterface<Locator::FilterEntry> &future, const QString &origEntry)
{
    QString entry = trimWildcards(origEntry);
    QList<Locator::FilterEntry> goodEntries;
    QList<Locator::FilterEntry> betterEntries;
    const QChar asterisk = QLatin1Char('*');
    QStringMatcher matcher(entry, Qt::CaseInsensitive);
    QRegExp regexp(asterisk + entry+ asterisk, Qt::CaseInsensitive, QRegExp::Wildcard);
    if (!regexp.isValid())
        return goodEntries;
    bool hasWildcard = (entry.contains(asterisk) || entry.contains(QLatin1Char('?')));
    bool hasColonColon = entry.contains(QLatin1String("::"));
    const Qt::CaseSensitivity caseSensitivityForPrefix = caseSensitivity(entry);

    const QList<QList<CppTools::ModelItemInfo> > itemLists = itemsToMatchUserInputAgainst();
    foreach (const QList<CppTools::ModelItemInfo> &items, itemLists) {
        foreach (const ModelItemInfo &info, items) {
            if (future.isCanceled())
                break;
            const QString matchString = hasColonColon ? info.scopedSymbolName() : info.symbolName;
            if ((hasWildcard && regexp.exactMatch(matchString))
                || (!hasWildcard && matcher.indexIn(matchString) != -1)) {
                const Locator::FilterEntry filterEntry = filterEntryFromModelItemInfo(info);
                if (matchString.startsWith(entry, caseSensitivityForPrefix))
                    betterEntries.append(filterEntry);
                else
                    goodEntries.append(filterEntry);
            }
        }
    }

    if (goodEntries.size() < 1000)
        qStableSort(goodEntries.begin(), goodEntries.end(), compareLexigraphically);
    if (betterEntries.size() < 1000)
        qStableSort(betterEntries.begin(), betterEntries.end(), compareLexigraphically);

    betterEntries += goodEntries;
    return betterEntries;
}

void CppLocatorFilter::accept(Locator::FilterEntry selection) const
{
    ModelItemInfo info = qvariant_cast<CppTools::ModelItemInfo>(selection.internalData);
    Core::EditorManager::openEditorAt(info.fileName, info.line, info.column);
}
