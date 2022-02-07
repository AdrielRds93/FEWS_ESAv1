* execute permissions on Linux
	run setExecutePermissions.sh once after you unzipped the bin

* Stand-Alone, Operator-Client or Config manager
    To launch a Delft-FEWS desktop application you need a (desktop) shortcut
    Please run the createShortcuts program
    .\windows\createShortcuts.exe
    ./linux/createShortcuts
    
* Forecasting Shells
    To start one or more forecasting shells run the fssLauncher on startup of your (virtual) machine.
    .\windows\fssLauncher.exe
    ./linux/fssLauncher
    
    The fssLauncher only needs environment variables. The directory structure and all root config files are created by the launcher. 
    Put these environment variables in your VM configuration, docker config or kubernetes config outside the VM image
    
    FEWS_FSS_HOME_DIR=c:\fews
    FEWS_FSS_INDEX_1_DATABASE_URL=jdbc:postgresql://hostname:6001/fewsdb01
    FEWS_FSS_INDEX_1_DATABASE_USER=username
    FEWS_FSS_INDEX_1_DATABASE_ENCRYPTED_PASSWORD=fdsfewqfaksdkja==
    FEWS_FSS_INDEX_1_CLIENT_CONFIG_FILE_NAME=fs_clientConfig.xml
    FEWS_FSS_INDEX_1_GROUP=windows
    
for more options and information see https://publicwiki.deltares.nl/display/FEWSDOC/Home
    
    
    
