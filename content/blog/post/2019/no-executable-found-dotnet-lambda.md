---
type: "post"
title: "No executable found matching command \"dotnet-lambda\""
date: 2019-05-01T21:01:03+01:00
author: "Jon"
tags: [
  "programming",
  "dotnetcore",
  "aws",
  "lambda"
]
---

When packaging up a dotnetcore lambda function for deployment to AWS, you would run the following command:

```
dotnet lambda package -o ../../build/{DestinationFileName}.zip
```

However, when I ran this command earlier today on a new Lambda function project, I got the following error:

```
No executable found matching command "dotnet-lambda"
```

This is because the Amazon.Lambda.Tools package isn't being included in the dotnet build process, so to fix things, I had to edit the .csproj file for the Lambda function to include the following:

```
  <ItemGroup>
    <DotNetCliToolReference Include="Amazon.Lambda.Tools" Version="2.1.3" />
  </ItemGroup>
```

and everything seemed to work fine afterwards.