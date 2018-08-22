NOTE: See my eBook "EclipseInAction.pdf".

Eclipse online documnentation:
o juno: http://help.eclipse.org/juno
o luna: https://help.eclipse.org/luna

Q: There is an exclamation icon next to the project name. What does it mean?
A: To see the issues or errors: "Window → Show View → Problems" or "Window → Show View → Error Log".
See: https://stackoverflow.com/questions/3812987/eclipse-shows-errors-but-i-cant-find-them

Q: How do I import or export my Eclipse preferences?
A: "File > Import" and "File > Export".
See https://help.eclipse.org/neon/index.jsp?topic=%2Forg.eclipse.platform.doc.user%2Ftasks%2Ftimpandexp.htm

Q: What is the .classpath file in my project directory (in my workspace folder)?
A: This contains the source and jar classpath entries. It can be edited manually, or using 
Example contents:
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
    <classpathentry kind="src" path="src"/>
    <classpathentry kind="src" path="test/java"/>
    <classpathentry kind="src" path="unittests/java"/>
    <classpathentry kind="src" path="unittests/testdata"/>
    <classpathentry kind="lib" path="3rdparty/apps/ant/lib/ant-junit.jar"/>
    <classpathentry kind="lib" path="3rdparty/apps/ant/lib/ant.jar"/>

Q: How do I create a "scrapbook" page to tryout some Java snippet?
A: "File > New > Other...." Then select "Java > Java Run/Debug > Scrapbook Page". 
See https://help.eclipse.org/neon/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Ftasks%2Ftask-create_scrapbook_page.htm

Q: What is an example command-line so that Eclipse can attach to the Java process?
A: java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000 Demo reports\MessagesReport.jasper output\output.pdf

Q: How do I launch Ecipse with an older Java version?
A: eclipse -vm c:\jrockit-jdk1.6.0_29-R28.2.0-4.1.0-x32\bin\javaw
