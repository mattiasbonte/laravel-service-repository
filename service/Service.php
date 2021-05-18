<?php

namespace App\Services\SERV_Upper_singular;

use Illuminate\Support\Collection;
use App\Repositories\SERV_Upper_singular\SERV_Upper_singularInterface;

SERV_lower_singular SERV_Upper_singularService
{
    /**
     * @var SERV_Upper_singularFieldInterface
     */
    protected SERV_Upper_singularInterface $SERV_lower_singularFieldInterface;

    /**
     * @param SERV_Upper_singularInterface $SERV_lower_singularInterface
     */
    public function __construct(SERV_Upper_singularInterface $SERV_lower_singularInterface)
    {
        $this->SERV_lower_singularInterface = $SERV_lower_singularInterface;
    }

    /**
     * Get SERV_lower_singular fields
     *
     * @param string $projectDatabaseName
     * @param string $SERV_lower_singularName
     *
     * @return Collection
     */
    public function getSERV_Upper_singularFields(string $projectDatabaseName, string $SERV_lower_singularName): Collection
    {
        return $this->SERV_lower_singularInterface->SERV_lower_singularFunction();
    }
}
