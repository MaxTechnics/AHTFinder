# Apple Hardware Test Finder
This bash script checks the Hardware Model, Board ID and returns the download link of the AHT dmg file you can use to diagnose your Mac.

## About Apple Hardware Test
Apple Hardware Test (AHT) was an often built in diagnostic tool used to detect problems with your Mac system. Apple changed to another Diagnostic system starting with Macs released in June 2013. This means that the script will not find a download for newer Macs as they do not support AHT. This is a great tool however to find the right link for your older Mac.

## Using this tool
There are 2 methods to use this tool. A little bit of command line knowledge will be handy though.

### Method 1: Using the package installer version
Download the latest release and unpack it. Double click the installer and follow the steps to install it. After install, open Terminal and enter ``/Applications/AHTFinder/AHTFinder.sh``

Now, use the tool however you want.

### Method 2: no-install method
Download the latest release, unzip it and open Terminal. Navigate to the directory of AHTFinder.sh (Make sure ``osx-cpu-temp`` and ``AHTFinder.sh`` are in the same folder)
Next, run AHTFinder.sh with ``./AHTFinder.sh``

Now, use the tool however you want.

## Creating a bootable USB drive for AHT
#### Step 0: Download the right version of the AHT image
#### Step 1: Prepare a USB Drive
Choose a USB drive with at least 512mb (recommended).

**Warning: During the following process all data on this drive will be erased! If you need the data on it, make a backup first.**

*I will not be liable for any loss of data*

Use Disk Utility to erase the usb drive. Make sure to format it as `Mac OS Journaled` with the `GUID Partition Table`
#### Step 2: Prepare the image
Take your .dmg file and double-click it to mount it.
#### Step 3: Copying the image to the USB Drive
Let's assume your usb drive is called 'Untitled'. This means that the mount point is `/Volumes/Untitled`. But this might differ. If you are unsure, unmount and disconnect all other storage drives except for your diagnostics drive. The mount point would be `/Volumes/{YourDrive}`.

Let's assume your .dmg file is mounted in ``/Volumes/AHT`` (Your image would be mounted in `/Volumes/{yourDMG}`)

Open Terminal and type the following command:

```sh
cp -r /Volumes/{yourDMG}/System /Volumes/{YourDrive}
```
This copies the system folder of the image to the usb drive. Fill in the parts between '{}' for your usecase. (don't just copy/paste this line)

#### Step 4: Make everything bootable
To make the USB drive bootable, enter the following command
```sh
sudo bless --folder /Volumes/{YourDrive}/ --file /Volumes/{YourDrive}/System/Library/CoreServices/.diagnostics/diags.efi --label AHT
```
You might need to enter your password to authenticate.

After this, you can safely close all windows. Eject the USB drive and plug it in the computer you want to test.

#### Step 5: Starting the diagnostics
Shut down the computer to test, press the power button and immediately hold down the `ALT/Option` key. When you see a boot menu, select the drive that is either called `AHT` or `EFI USB` (or something similar).

You have now succesfully started the diagnostic tool. Congratulations!

## Download codes in the script

| Hardware Model | Board ID                  | Download Code | Bundle? | In script? | Tested and Verified |
|----------------|---------------------------|---------------|---------|------------|---------------------|
| iMac4,1        | 3A103                     | 018-2392-A    | No      | Yes        | No                  |
| iMac5,1        | Mac-F4228EC8              | 018-2534-A    | No      | Yes        | No                  |
| iMac5,1        | Mac-F42786A9              | 018-2533-A    | No      | Yes        | No                  |
| iMac5,2        | Mac-F4218EC8              | 018-2535-A    | No      | Yes        | No                  |
| iMac5,2        | Mac-F4218EC8              | 018-2418-A    | No      | Yes        | No                  |
| iMac5,2        | Mac-F4218EC8              | 018-3254-A    | Yes     | Yes        | No                  |
| iMac6,1        | Mac-F4218FC8              | 018-2579-A    | No      | Yes        | No                  |
| iMac7,1        | Mac-F42386C8              | 018-2845-A    | No      | Yes        | No                  |
| iMac7,1        | Mac-F42386C8              | 018-3169-A    | Yes     | Yes        | No                  |
| iMac7,1        | Mac-F42386C8              | 018-3254-A    | Yes     | Yes        | No                  |
| iMac7,1        | Mac-F4238CC8              | 018-3169-A    | Yes     | Yes        | No                  |
| iMac7,1        | Mac-F4238CC8              | 018-3254-A    | Yes     | Yes        | No                  |
| iMac7,1        | Mac-F4238CC8              | 018-3169-A    | Yes     | Yes        | No                  |
| iMac8,1        | Mac-F226BEC8              | 022-3936-A    | No      | Yes        | No                  |
| iMac8,1        | Mac-F227BEC8              | 022-3937-A    | No      | Yes        | No                  |
| iMac9,1        | Mac-F2218EA9              | 022-4297-A    | No      | Yes        | No                  |
| iMac9,1        | Mac-F2218EC8              | 022-4293-A    | No      | Yes        | No                  |
| iMac9,1        | Mac-F2218FC8              | 022-4294-A    | No      | Yes        | No                  |
| iMac10,1       | Mac-F2268CC8              | 022-4451-A    | No      | Yes        | No                  |
| iMac10,1       | Mac-F2268CC8              | 022-4647-A    | No      | Yes        | No                  |
| iMac10,1       | Mac-F2268DC8              | 022-4452-A    | No      | Yes        | No                  |
| iMac10,1       | Mac-F2268DC8              | 022-4644-A    | No      | Yes        | No                  |
| iMac11,2       | Mac-F2238AC8              | 022-4703-A    | No      | Yes        | No                  |
| iMac11,3       | Mac-F2238BAE              | 022-4776-A    | No      | Yes        | No                  |
| iMac12,1       | Mac-942B5BF58194151B      | 022-5090-A    | No      | Yes        | No                  |
| iMac12,1       | Mac-942B5BF58194151B      | 022-5344-A    | No      | Yes        | No                  |
| iMac12,1       | Mac-942B5BF58194151B      | 022-5348-A    | Yes     | Yes        | No                  |
| iMac12,1       | Mac-942B5BF58194151B      | 022-6031-A    | Yes     | Yes        | No                  |
| iMac12,2       | Mac-942B59F58194171B      | 022-5091-A    | No      | Yes        | No                  |
| iMac12,2       | Mac-942B59F58194171B      | 022-5348-A    | Yes     | Yes        | No                  |
| iMac13,1       | Mac-00BE6ED71E35EB86      | 022-6031-A    | Yes     | Yes        | No                  |
| iMac13,2       | Mac-FC02E91DDD3FA6A4      | 022-6031-A    | Yes     | Yes        | No                  |
| Macmini1,1     | 3A102                     | 018-2342-A    | No      | Yes        | No                  |
| Macmini2,1     | Mac-F4208EAA              | 018-2886-A    | No      | Yes        | No                  |
| Macmini2,1     | Mac-F4208EAA              | 018-3169-A    | Yes     | Yes        | No                  |
| Macmini2,1     | Mac-F4208EAA              | 018-3254-A    | Yes     | Yes        | No                  |
| Macmini3,1     | Mac-F22C86C8              | 022-4292-A    | No      | Yes        | No                  |
| Macmini4,1     | Mac-F2208EC8 (NOT SERVER) | 022-4706-A    | No      | Yes        | No                  |
| Macmini4,1     | Mac-F2208EC8 (SERVER)     | 022-4739-A    | No      | Yes        | Yes                 |
| Macmini5,1     | Mac-8ED6AF5B48C039E1      | 022-5207-A    | No      | Yes        | No                  |
| Macmini5,2     | Mac-4BC72D62AD45599E      | 022-5207-A    | No      | Yes        | No                  |
| Macmini6,1     | Mac-031AEE4D24BFF0B1      | 022-6031-A    | Yes     | Yes        | No                  |
| Macmini6,2     | Mac-F65AE981FFA204ED      | 022-6031-A    | Yes     | Yes        | No                  |
| MacPro1,1      | Mac-F4208DC8              | 018-2769-A    | No      | Yes        | No                  |
| MacPro1,1      | Mac-F4208DC8              | 018-2418-A    | No      | Yes        | No                  |
| MacPro1,1      | Mac-F4208DC8              | 018-3254-A    | Yes     | Yes        | No                  |
| MacPro2,1      | Mac-F4208DA9              | 018-2667-A    | No      | Yes        | No                  |
| MacPro2,1      | Mac-F4208DA9              | 018-3169-A    | Yes     | Yes        | No                  |
| MacPro2,1      | Mac-F4208DA9              | 018-3254-A    | Yes     | Yes        | No                  |
| MacPro3,1      | Mac-F42C88C8              | 018-3273-A    | No      | Yes        | No                  |
| MacPro3,1      | Mac-F42C88C8              | 022-3843-A    | No      | Yes        | No                  |
| MacPro3,1      | Mac-F42C88C8              | 022-4020-A    | No      | Yes        | No                  |
| MacPro4,1      | Mac-F221BEC8              | 022-5348-A    | Yes     | Yes        | No                  |
| MacPro4,1      | Mac-F221BEC8              | 022-4149-A    | No      | Yes        | No                  |
| MacPro5,1      | Mac-F221BEC8              | 022-4831-A    | No      | Yes        | No                  |
| MacPro5,1      | Mac-F221BEC8              | 022-5348-A    | Yes     | Yes        | No                  |
| MacBook2,1     | Mac-F4208CA9              | 018-2590-A    | No      | Yes        | No                  |
| MacBook2,1     | Mac-F4208CAA              | 018-2766-A    | No      | Yes        | No                  |
| MacBook3,1     | Mac-F22788C8              | 018-3085-A    | No      | Yes        | No                  |
| MacBook3,1     | Mac-F22788C8              | 018-3254-A    | Yes     | Yes        | No                  |
| MacBook3,1     | Mac-F22788C8              | 018-3169-A    | Yes     | Yes        | No                  |
| MacBook4,1     | Mac-F22788A9              | 022-3862-A    | No      | Yes        | No                  |
| MacBook5,1     | Mac-F42D89A9              | 022-4216-A    | No      | Yes        | No                  |
| MacBook5,1     | Mac-F42D89C8              | 022-4037-A    | No      | Yes        | No                  |
| MacBook5,2     | Mac-F22788AA              | 022-4299-A    | No      | Yes        | No                  |
| MacBook6,1     | Mac-F22C8AC8              | 022-4453-A    | No      | Yes        | No                  |
| MacBook6,1     | Mac-F22C8AC8              | 022-5348-A    | Yes     | Yes        | No                  |
| MacBook7,1     | Mac-F22C89C8              | 022-4705-A    | No      | Yes        | No                  |
| MacBook7,1     | Mac-F22C89C8              | 022-5348-A    | Yes     | Yes        | No                  |
| MacBookPro1,1  | 3A106                     | 018-2398-A    | No      | Yes        | No                  |
| MacBookPro1,1  | 3A107                     | 018-2405-A    | No      | Yes        | No                  |
| MacBookPro2,1  | Mac-F42189C8              | 018-2592-A    | No      | Yes        | No                  |
| MacBookPro2,2  | Mac-F42187C8              | 018-2591-A    | No      | Yes        | Testing             |
| MacBookPro3,1  | Mac-F42388C8              | 018-2833-A    | No      | Yes        | No                  |
| MacBookPro3,1  | Mac-F42388C8              | 018-3169-A    | Yes     | Yes        | No                  |
| MacBookPro3,1  | Mac-F42388C8              | 018-3254-A    | Yes     | Yes        | No                  |
| MacBookPro3,1  | Mac-F4238BC8              | 018-2770-A    | No      | Yes        | No                  |
| MacBookPro3,1  | Mac-F4238BC8              | 018-3169-A    | Yes     | Yes        | No                  |
| MacBookPro3,1  | Mac-F4238BC8              | 018-3254-A    | Yes     | Yes        | No                  |
| MacBookPro4,1  | Mac-F42C86C8              | 022-3832-A    | No      | Yes        | No                  |
| MacBookPro4,1  | Mac-F42C89C8              | 022-3833-A    | No      | Yes        | No                  |
| MacBookPro5,1  | Mac-F42D86A9              | 022-4266-A    | No      | Yes        | No                  |
| MacBookPro5,1  | Mac-F42D86C8              | 022-4048-A    | No      | Yes        | No                  |
| MacBookPro5,2  | Mac-F2268EC8              | 022-4217-A    | No      | Yes        | No                  |
| MacBookPro5,3  | Mac-F22587C8              | 022-4343-A    | No      | Yes        | No                  |
| MacBookPro5,4  | Mac-F22587A1              | 022-4344-A    | No      | Yes        | No                  |
| MacBookPro5,5  | Mac-F2268AC8              | 022-4339-A    | No      | Yes        | No                  |
| MacBookPro6,1  | Mac-F22589C8              | 022-4596-A    | No      | Yes        | No                  |
| MacBookPro6,2  | Mac-F22586C8              | 022-4597-A    | No      | Yes        | No                  |
| MacBookPro7,1  | Mac-F222BEC8              | 022-4653-A    | No      | Yes        | No                  |
| MacBookPro8,1  | Mac-94245B3640C91C81      | 022-5052-A    | No      | Yes        | No                  |
| MacBookPro8,1  | Mac-94245B3640C91C81      | 022-5348-A    | Yes     | Yes        | No                  |
| MacBookPro8,2  | Mac-94245A3940C91C80      | 022-5053-A    | No      | Yes        | No                  |
| MacBookPro8,2  | Mac-94245A3940C91C80      | 022-5348-A    | Yes     | Yes        | No                  |
| MacBookPro8,3  | Mac-942459F5819B171B      | 022-5054-A    | No      | Yes        | No                  |
| MacBookPro8,3  | Mac-942459F5819B171B      | 022-5348-A    | Yes     | Yes        | No                  |
| MacBookPro9,1  | Mac-4B7AC7E43945597E      | 022-5879-A    | No      | Yes        | No                  |
| MacBookPro9,1  | Mac-4B7AC7E43945597E      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookPro9,2  | Mac-6F01561E16C75D06      | 022-5879-A    | No      | Yes        | No                  |
| MacBookPro9,2  | Mac-6F01561E16C75D06      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookPro9,2  | Mac-7DF2A3B5E5D671ED      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookPro10,1 | Mac-C3EC7CD22292981F      | 022-5882-A    | No      | Yes        | No                  |
| MacBookPro10,1 | Mac-C3EC7CD22292981F      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookPro10,2 | Mac-AFD8A9D944EA4843      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookAir1,1  | Mac-F42C8CC8              | 018-3259-A    | No      | Yes        | No                  |
| MacBookAir2,1  | Mac-F42D88C8              | 022-4114-A    | No      | Yes        | No                  |
| MacBookAir3,1  | Mac-942452F5819B1C1B      | 022-4704-A    | No      | Yes        | No                  |
| MacBookAir3,2  | Mac-942C5DF58193131B      | 022-4267-A    | No      | Yes        | No                  |
| MacBookAir4,1  | Mac-C08A6BB70A942AC2      | 022-5205-A    | No      | Yes        | No                  |
| MacBookAir4,2  | Mac-742912EFDBEE19B3      | 022-5205-A    | No      | Yes        | No                  |
| MacBookAir5,1  | Mac-66F35F19FE2A0D05      | 022-5745-A    | No      | Yes        | No                  |
| MacBookAir5,1  | Mac-66F35F19FE2A0D05      | 022-6031-A    | Yes     | Yes        | No                  |
| MacBookAir5,2  | Mac-2E6FAB96566FE58C      | 022-5745-A    | No      | Yes        | No                  |
| MacBookAir5,2  | Mac-2E6FAB96566FE58C      | 022-6031-A    | Yes     | Yes        | No                  |
| Xserve1,1      | Mac-F4208AC8              | 018-3282-A    | No      | Yes        | No                  |
| Xserve2,1      | Mac-F42289C8              | 018-3282-A    | No      | Yes        | No                  |


## Other download codes
#### iMac
* [iMac v2.5.1GMc1](018-1879-A)
* [iMac v2.5.2GMc5](018-2158-A)
* [iMac v2.5.3GMc1](018-2215-A)

#### Macmini
* [MacMini v1.1GMc2](018-2079-A)

#### PowerMac

* [PowerMac v1.2.6, PowerMac G4](http://download.info.apple.com/Apple_Hardware_Test/693-3994-A.dmg)
* [PowerMac v2.2.5GMc2](http://download.info.apple.com/Apple_Hardware_Test/018-1594-A.dmg)
* [PowerMac v2.5GMc1](http://download.info.apple.com/Apple_Hardware_Test/018-1880-A.dmg)
* [PowerMac v2.5.2GMc1](http://download.info.apple.com/Apple_Hardware_Test/018-2216-A.dmg)

#### PowerBook

* [PowerBook v1.2.3, PowerBook FireWire, PowerBook G4](http://download.info.apple.com/Apple_Hardware_Test/693-4420-A.dmg)
* [PowerBook v2.5.2GMc1](http://download.info.apple.com/Apple_Hardware_Test/018-2120-A.dmg)

#### iBook

* [iBook v2.2.1GMc1](http://download.info.apple.com/Apple_Hardware_Test/018-1680-A.dmg)
* [iBook v2.5GMc1](http://download.info.apple.com/Apple_Hardware_Test/018-2056-A.dmg)


#### Unknown Download Codes
* [unidentified](018-2393-A), possibly [MacBook1,1 Mac-F4208CC8]

## Contributing
Please notify me by opening an issue if you find something that's wrong. Is the wrong model shown? Is a link not/no longer working? Please report it. Be sure to mention the Hardware Model and Board ID and if the wrong one is mentioned also what the wrong model is. This way, fixing bugs is much easier.

If you do end up using this, please also open an issue mentioning your test results so i can update the tested and verified column. Open an issue with title: verification or something like that, mention the used download code, Board ID and Hardware Model. Thank you in advance!

## Used tools, libraries and repos
- All download codes were originally found by upekkha and put in [this](https://github.com/upekkha/AppleHardwareTest) repository. Credits go to [upekkha](https://github.com/upekkha/)!

- An old version of Xcode was used to write this. It is not recommended!

- [osx-cpu-temp by lavoiesl](https://github.com/lavoiesl/osx-cpu-temp)
