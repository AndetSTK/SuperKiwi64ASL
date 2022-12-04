state("SuperKiwi64") {}
startup
{
    Assembly.Load(File.ReadAllBytes(@"Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
}

init
{
    vars.Helper.TryLoadTimeout = 200;
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["kiwiActive"] = mono.Make<int>("GameManager", "singleton", "myPlayerSystem", "_headposnorm");
        vars.Helper["nextLevelID"] = mono.Make<int>("GameManager", "singleton", "NextLevelID");
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name;
}

start
{
    return (current.kiwiActive > old.kiwiActive);
    
}

split
{
    if (old.loadingScene != "Hubworld" && current.loadingScene == "Hubworld") {return true;}
    return (old.nextLevelID != 12 && current.nextLevelID == 12);
}

isLoading
{
    return (current.activeScene != current.loadingScene);
}