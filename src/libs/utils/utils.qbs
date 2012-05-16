import qbs.base 1.0
import "../QtcLibrary.qbs" as QtcLibrary

QtcLibrary {
    name: "Utils"

    cpp.defines: ["QTCREATOR_UTILS_LIB"]
    cpp.includePaths: [ ".", "..",
        "../..",
        "../3rdparty/botan/build",
        "ssh",
        buildDirectory
    ]

    Properties {
        condition: qbs.targetOS == "windows"
        cpp.dynamicLibraries: ["user32", "iphlpapi", "ws2_32"]
    }
    Properties {
        condition: qbs.targetOS === "linux"
        cpp.dynamicLibraries: ["X11"]
    }

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ['widgets', 'network', 'script', 'concurrent'] }
    Depends { name: "Botan" }
    Depends { name: "app_version_header" }

    files: [
        "filewizardpage.ui",
        "newclasswidget.ui",
        "projectintropage.ui",
        "utils.qrc",
        "annotateditemdelegate.cpp",
        "annotateditemdelegate.h",
        "basetreeview.cpp",
        "basetreeview.h",
        "basevalidatinglineedit.cpp",
        "basevalidatinglineedit.h",
        "buildablehelperlibrary.h",
        "changeset.cpp",
        "changeset.h",
        "classnamevalidatinglineedit.cpp",
        "classnamevalidatinglineedit.h",
        "codegeneration.cpp",
        "codegeneration.h",
        "completingtextedit.cpp",
        "completingtextedit.h",
        "consoleprocess.cpp",
        "consoleprocess.h",
        "consoleprocess_p.h",
        "crumblepath.h",
        "detailsbutton.cpp",
        "detailsbutton.h",
        "detailswidget.cpp",
        "detailswidget.h",
        "environment.h",
        "environmentmodel.cpp",
        "environmentmodel.h",
        "faketooltip.cpp",
        "faketooltip.h",
        "fancylineedit.cpp",
        "fancylineedit.h",
        "fancymainwindow.cpp",
        "fancymainwindow.h",
        "appmainwindow.h",
        "appmainwindow.cpp",
        "fileinprojectfinder.cpp",
        "fileinprojectfinder.h",
        "filenamevalidatinglineedit.h",
        "filesearch.cpp",
        "filesearch.h",
        "filesystemwatcher.cpp",
        "filesystemwatcher.h",
        "fileutils.h",
        "filewizarddialog.cpp",
        "filewizarddialog.h",
        "filewizardpage.cpp",
        "filewizardpage.h",
        "filterlineedit.cpp",
        "filterlineedit.h",
        "flowlayout.cpp",
        "flowlayout.h",
        "historycompleter.h",
        "htmldocextractor.cpp",
        "htmldocextractor.h",
        "ipaddresslineedit.h",
        "iwelcomepage.cpp",
        "iwelcomepage.h",
        "json.cpp",
        "json.h",
        "linecolumnlabel.cpp",
        "linecolumnlabel.h",
        "listutils.h",
        "navigationtreeview.cpp",
        "navigationtreeview.h",
        "networkaccessmanager.h",
        "newclasswidget.cpp",
        "newclasswidget.h",
        "outputformat.h",
        "outputformatter.cpp",
        "outputformatter.h",
        "parameteraction.cpp",
        "parameteraction.h",
        "pathchooser.cpp",
        "pathchooser.h",
        "pathlisteditor.h",
        "projectintropage.cpp",
        "projectintropage.h",
        "projectnamevalidatinglineedit.cpp",
        "projectnamevalidatinglineedit.h",
        "proxyaction.h",
        "qtcassert.h",
        "qtcassert.cpp",
        "qtcolorbutton.cpp",
        "qtcolorbutton.h",
        "qtcprocess.h",
        "reloadpromptutils.cpp",
        "reloadpromptutils.h",
        "savedaction.h",
        "savefile.cpp",
        "savefile.h",
        "settingsselector.cpp",
        "settingsutils.h",
        "statuslabel.cpp",
        "statuslabel.h",
        "stringutils.cpp",
        "stringutils.h",
        "styledbar.cpp",
        "styledbar.h",
        "stylehelper.h",
        "submiteditorwidget.cpp",
        "submiteditorwidget.h",
        "submiteditorwidget.ui",
        "submitfieldwidget.cpp",
        "submitfieldwidget.h",
        "synchronousprocess.cpp",
        "synchronousprocess.h",
        "tcpportsgatherer.cpp",
        "tcpportsgatherer.h",
        "textfileformat.cpp",
        "textfileformat.h",
        "treewidgetcolumnstretcher.cpp",
        "treewidgetcolumnstretcher.h",
        "uncommentselection.cpp",
        "uncommentselection.h",
        "utils_global.h",
        "wizard.cpp",
        "wizard.h",
        "persistentsettings.h",
        "settingsselector.h",
        "buildablehelperlibrary.cpp",
        "checkablemessagebox.cpp",
        "checkablemessagebox.h",
        "crumblepath.cpp",
        "environment.cpp",
        "filenamevalidatinglineedit.cpp",
        "fileutils.cpp",
        "historycompleter.cpp",
        "ipaddresslineedit.cpp",
        "networkaccessmanager.cpp",
        "pathlisteditor.cpp",
        "persistentsettings.cpp",
        "portlist.cpp",
        "portlist.h",
        "proxyaction.cpp",
        "qtcprocess.cpp",
        "savedaction.cpp",
        "stylehelper.cpp",
        "multitask.h",
        "runextensions.h",
        "images/arrow.png",
        "images/crumblepath-segment-end.png",
        "images/crumblepath-segment-hover-end.png",
        "images/crumblepath-segment-hover.png",
        "images/crumblepath-segment-selected-end.png",
        "images/crumblepath-segment-selected.png",
        "images/crumblepath-segment.png",
        "images/removesubmitfield.png",
        "images/triangle_vert.png",
        "ssh/sftpchannel.h",
        "ssh/sftpchannel_p.h",
        "ssh/sftpdefs.cpp",
        "ssh/sftpdefs.h",
        "ssh/sftpincomingpacket.cpp",
        "ssh/sftpincomingpacket_p.h",
        "ssh/sftpoperation.cpp",
        "ssh/sftpoperation_p.h",
        "ssh/sftpoutgoingpacket.cpp",
        "ssh/sftpoutgoingpacket_p.h",
        "ssh/sftppacket.cpp",
        "ssh/sftppacket_p.h",
        "ssh/sshbotanconversions_p.h",
        "ssh/sshcapabilities_p.h",
        "ssh/sshchannel.cpp",
        "ssh/sshchannel_p.h",
        "ssh/sshchannelmanager.cpp",
        "ssh/sshchannelmanager_p.h",
        "ssh/sshconnection.h",
        "ssh/sshconnection_p.h",
        "ssh/sshconnectionmanager.cpp",
        "ssh/sshconnectionmanager.h",
        "ssh/sshcryptofacility.cpp",
        "ssh/sshcryptofacility_p.h",
        "ssh/ssherrors.h",
        "ssh/sshexception_p.h",
        "ssh/sshincomingpacket_p.h",
        "ssh/sshkeyexchange.cpp",
        "ssh/sshkeyexchange_p.h",
        "ssh/sshkeypasswordretriever_p.h",
        "ssh/sshoutgoingpacket.cpp",
        "ssh/sshoutgoingpacket_p.h",
        "ssh/sshpacket.cpp",
        "ssh/sshpacket_p.h",
        "ssh/sshpacketparser.cpp",
        "ssh/sshpacketparser_p.h",
        "ssh/sshpseudoterminal.h",
        "ssh/sshremoteprocess.cpp",
        "ssh/sshremoteprocess.h",
        "ssh/sshremoteprocess_p.h",
        "ssh/sshremoteprocessrunner.cpp",
        "ssh/sshremoteprocessrunner.h",
        "ssh/sshsendfacility.cpp",
        "ssh/sshsendfacility_p.h",
        "ssh/sshkeypasswordretriever.cpp",
        "ssh/sftpchannel.cpp",
        "ssh/sshcapabilities.cpp",
        "ssh/sshconnection.cpp",
        "ssh/sshincomingpacket.cpp",
        "ssh/sshkeygenerator.cpp",
        "ssh/sshkeygenerator.h",
        "ssh/sshkeycreationdialog.cpp",
        "ssh/sshkeycreationdialog.h",
        "ssh/sshkeycreationdialog.ui"
    ]

    Group {
        condition: qbs.targetOS == "windows"
        files: [
            "consoleprocess_win.cpp",
            "winutils.cpp",
            "winutils.h",
            "process_ctrlc_stub.cpp"
        ]
    }

    Group {
        condition: qbs.targetOS == "linux" || qbs.targetOS == "mac"
        files: [
            "consoleprocess_unix.cpp",
        ]
    }

    Group {
        condition: qbs.targetOS == "linux"
        files: [
            "unixutils.h",
            "unixutils.cpp"
        ]
    }

    ProductModule {
        Depends { name: "Qt"; submodules: ["concurrent", "widgets", "network"] }
    }
}

