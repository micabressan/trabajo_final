val code3 = """
              |List(
              |  1,
              |  1,
              |  2
              |  )
            """.stripMargin

"(?m)^[ \t]*\\)".r.findFirstMatchIn(code3)