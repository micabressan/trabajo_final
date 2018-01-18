Index: lang/scala/repository/src/reflect/scala/reflect/internal/Types.scala
IDEA additional info:
Subsystem: com.intellij.openapi.diff.impl.patch.CharsetEP
<+>UTF-8
===================================================================
--- lang/scala/repository/src/reflect/scala/reflect/internal/Types.scala	(date 1513884074000)
+++ lang/scala/repository/src/reflect/scala/reflect/internal/Types.scala	(revision )
@@ -585,6 +585,9 @@
      */
     def decl(name: Name): Symbol = findDecl(name, 0)
 
+    /** Search for symbols that are packets. */
+    def declPackage(name:Name):Symbol = findDeclWithFlag(name, Flags.PACKAGE)
+
     /** A list of all non-private members defined or declared in this type. */
     def nonPrivateDecls: List[Symbol] = decls.filterNot(_.isPrivate).toList
 
@@ -984,12 +987,12 @@
     /** If this is a symbol loader type, load and assign a new type to `sym`. */
     def load(sym: Symbol) {}
 
-    private def findDecl(name: Name, excludedFlags: Int): Symbol = {
+    private def findDeclPredecate(name: Name, condition:(Symbol) ⇒ Boolean): Symbol = {
       var alts: List[Symbol] = List()
       var sym: Symbol = NoSymbol
       var e: ScopeEntry = decls.lookupEntry(name)
       while (e ne null) {
-        if (!e.sym.hasFlag(excludedFlags.toLong)) {
+        if (condition(e.sym)) {
           if (sym == NoSymbol) sym = e.sym
           else {
             if (alts.isEmpty) alts = sym :: Nil
@@ -1002,6 +1005,10 @@
       else (baseClasses.head.newOverloaded(this, alts))
     }
 
+    private def findDecl(name: Name, excludedFlags: Int): Symbol = findDeclPredecate(name, !_.hasFlag(excludedFlags.toLong))
+
+    private def findDeclWithFlag(name:Name, requiredFlags:Int): Symbol = findDeclPredecate(name, _.hasAllFlags(requiredFlags.toLong))
+
     /** Find all members meeting the flag requirements.
      *
      * If you require a DEFERRED member, you will get it if it exists -- even if there's an overriding concrete member.