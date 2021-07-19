<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitc7eb38362f0298474dcbea52ec157281
{
    public static $prefixLengthsPsr4 = array (
        'O' => 
        array (
            'Onliner\\Counter\\' => 16,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Onliner\\Counter\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitc7eb38362f0298474dcbea52ec157281::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitc7eb38362f0298474dcbea52ec157281::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInitc7eb38362f0298474dcbea52ec157281::$classMap;

        }, null, ClassLoader::class);
    }
}