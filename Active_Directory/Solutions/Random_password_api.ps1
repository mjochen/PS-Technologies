function replace-multipleCharacters
{
    param([string] $word )

    $special = "ŠŽšžŸÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðñòóôõöùúûüýÿ"
    $normal  = "SZszYAAAAAACEEEEIIIIDNOOOOOUUUUYaaaaaaceeeeiiiidnooooouuuuyy"

    for($i=0;$i -lt $special.Length; $i++)
    {
        $word = $word -creplace $special[$i], $normal[$i]

    }

    return $word
}

replace-multipleCharacters -word "Mariën"